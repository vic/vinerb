module Vinerb

  module Decorators
    def decorate(*method_names, &with_block)
      method_names.each do |method_name|
        unbound_method = instance_method(method_name)
        define_method(method_name) do |*args, &block|
          bound_method = unbound_method.bind(self)
          with_block.call(bound_method, args, block)
        end
      end
    end


    CHAINER = lambda { |m, a, b| m.call(*a, &b); self }
    OBJECT_OR_ID = lambda do |m, a, b|
      obj = a.first || self
      if obj.instance_of?(self.class)
        a[0] = obj.id
      end
      m.call(*a, &b)
    end
    ENSURE_OWNER = lambda do |m, a, b|
      raise Vinerb::Error("Trying to call a method on non-owned user") unless key
      m.call(*a, &b)
    end


  end

  module Model

    attr_reader   :api, :json

    ATTRIBUTE_TO_MODEL_NAME = {
      'user'     => 'User',
      'tags'     => 'Tag',
      'entities' => 'Entity',
      'comments' => 'CommentCollection',
      'likes'    => 'LikeCollection',
      'reposts'  => 'PostCollection'
    }

    def self.build_attributes(class_name, attributes = {}, api = nil)
      attributes.inject({}) do |h, pair|
        k, v = pair
        if ATTRIBUTE_TO_MODEL_NAME.key?(k)
          model = ATTRIBUTE_TO_MODEL_NAME[k]
          if v.kind_of?(Array)
            h[k] = v.map { |o| build(model, o, api) }
          else
            h[k] = build(model, v, api)
          end
        elsif k =~ /#{class_name}Id/i
          h['id'] = v
        elsif k =~ /created/i
          h[k] = Date.strptime v, '%Y-%m-%dT%H:%M:%S.%f'
        else
          h[k] = v
        end
        h
      end
    end

    def self.build(class_name, attributes = {}, api = nil)
      clazz = const_get(class_name)
      instance = clazz.new

      attrs = build_attributes(class_name, attributes, api)

      instance.instance_variable_set(:@api, api)
      instance.instance_variable_set(:@json, attributes)
      instance.instance_variable_set(:@__attr__, attrs)

      clazz.module_eval do
        attrs.each_key do |name|
          define_method(name) { @__attr__[name] } unless method_defined?(name)
        end
      end

      instance
    end

    module Collection

      include Enumerable

      def each(*a, &b)
        records.each(*a, &b)
      end

    end


    class User

      include Model

      extend Decorators

      def self.login(email, password)
        api = API.new
        user = api.login(email, password)
        user.api.key = user.key
        user.api.user_id = user.id
        user
      end

      # username => Full name
      # 
      def self.signup(email, password, full_name)
        api = API.new
        user = api.signup(email, password, full_name)
        user.api.key = user.key
        user.api.user_id = user.id
        user
      end

      def logout
        api.logout
        api.key = self.key = nil
      end

      def profile
        api.get_user(id)
      end

      def profile!
        new_user = profile
        @json = new_user.json
        @__attr__ = new_user.instance_variable_get :@__attr__
      end

      #
      # This method can be used in two ways:
      #
      # If given a user_id
      # 
      #   me....
      #
      # Otherwise the user in current context
      #
      #   me.followers.first.followdasdasdsa
      #
      def follow(user = nil)
        api.follow user
      end

      def unfollow(user = nil)
        api.unfollow user
      end

      def following?
        !@__attr__['following'].zero?
      end

      def block(user = nil)
        api.block user.id
      end
      
      def unblock(user = nil)
        api.unblock user.id
      end

      def blocking?
        !blocking.zero?
      end

      def followers(params = {})
        api.get_followers id, params
      end

      def following(params = {})
        api.get_following id, params
      end

      def notifications(params = {})
        api.get_notifications id, params
      end

      def pending_notifications_count
        api.get_pending_notifications_count id
      end

      def update_profile(profile = {})
        api.update_profile profile
      end

      def explicit=(flag)
        flag && api.set_explicit(id) || api.unset_explicit(id)
      end

      def explicit?
        !explicitContent.zero?
      end

      def verified?
        !verified.zero?
      end

      def timeline(params = {})
        api.get_user_timeline id, params
      end

      def likes(params = {})
        api.get_user_likes id, params
      end

      decorate :follow, :unfollow, :block, :unblock, &Decorators::OBJECT_OR_ID
      decorate :logout, :profile!, :follow, :unfollow, :block, :unblock, :update_profile, :explicit=, &Decorators::CHAINER
      decorate :logout, :notifications, :pending_notifications_count, &Decorators::ENSURE_OWNER

    end


    class Post

      include Model

      extend Decorators

      # def post
      # end

      def like
        api.like id
      end

      def unlike
        api.unlike id
      end

      def repost
        api.repost id
      end
      alias_method :revine, :repost

      def unrepost repost
        if repost.instance_of?(Repost)
          repost = repost.id
        end
        api.unrepost id, repost
      end

      def report
        api.report id
      end

      # def comment

      # end

      def delete
        api.delete_post id
      end

      def likes(params = {})
        api.get_likes id, params
      end

      def comments(params = {})
        api.get_comments id, params
      end

      def reposts(params = {})
        api.get_reposts id, params
      end
      alias_method :revines, :reposts

      decorate :like, :unlike, :report, &Decorators::CHAINER
    end


    class Like

      include Model

      def delete
        raise Vinerb::Error("Trying to call a method on non-owned user") unless user.id != api.user_id
        api.unlike post.id
      end
      alias_method :unlike, :delete

    end


    class Comment

      include Model

      def delete
        raise Vinerb::Error("Trying to call a method on non-owned user") unless user.id != api.user_id
        api.uncomment post.id id
      end
      alias_method :uncomment, :delete

    end


    class Repost

      include Model

      def delete
        raise Vinerb::Error("Trying to call a method on non-owned user") unless user.id != api.user_id
        api.uncomment post.id id
      end
      alias_method :unrepost, :delete
      alias_method :unrevine, :delete

    end


    class Tag

      include Model

    end


    class Channel

      include Model

    end


    class UserCollection
      include Collection
    end

    class PostCollection
      include Collection
    end

    class TagCollection
      include Collection
    end

    class ChannelCollection
      include Collection
    end

    class LikeCollection
      include Collection
    end

  end

end

