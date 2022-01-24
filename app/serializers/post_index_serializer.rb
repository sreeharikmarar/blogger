# frozen_string_literal: true

class PostIndexSerializer
  def initialize(post)
    @post = post
  end

  def as_json
    {
      id: @post.id,
      title: @post.title,
      content: @post.content,
      author: @post.user.name
    }
  end
end
