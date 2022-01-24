# frozen_string_literal: true

class PostSerializer
  def initialize(post)
    @post = post
  end

  def as_json
    {
      title: @post.title,
      content: @post.content,
      author: @post.user.name
    }
  end
end
