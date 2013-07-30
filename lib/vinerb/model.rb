module Vinerb::Model

  def self.build(clazz, attributes = {})
    clazz = const_get(clazz)
    instance = clazz.new
    attributes.each { |n,v| instance["#{n}"] = v }
  end

  class User < Struct.new(:username, :email, :password)

  end

  class Post < Struct.new
    # has_many :comments, :likes, :reports, :tags
  end

  class Like < Struct.new

  end

  class Comment < Struct.new

  end

  class Repost < Struct.new

  end

  class Tag < Struct.new

  end

  class Channel
  end

  class UserCollection
    # followers / following
  end

  class PostCollection
    # timeline ( popular, user, editorpicks, trending)
  end

  class TagCollection
  end

  class ChannelCollection
  end

end
