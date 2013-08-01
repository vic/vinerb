module Vinerb

  module Model

    attr_reader :json

    ATTRIBUTE_TO_MODEL_NAME = {
      'user'     => 'User',
      'tags'     => 'Tag',
      'entities' => 'Entity',
      'comments' => 'CommentCollection',
      'likes'    => 'LikeCollection',
      'reposts'  => 'PostCollection'
    }

    def self.build_attributes(attributes = {})
      attributes.inject({}) do |h, pair|
        k, v = pair
        if ATTRIBUTE_TO_MODEL_NAME.key?(k)
          model = ATTRIBUTE_TO_MODEL_NAME[k]
          if v.kind_of?(Array)
            h[k] = v.map { |o| build(model, o) }
          else
            h[k] = build(model, v)
          end
        else
          h[k] = v
        end
        h
      end
    end

    def self.build(clazz, attributes = {})
      clazz = const_get(clazz)
      instance = clazz.new

      instance.instance_variable_set(:@json, attributes)
      instance.instance_variable_set(:@__attr__, build_attributes(attributes))

      clazz.module_eval do
        attributes.each_key do |name|
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

    end

    class Post

      include Model

    end

    class Like

      include Model

    end

    class Comment

      include Model

    end

    class Repost

      include Model

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
