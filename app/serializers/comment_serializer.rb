# frozen_string_literal: true

class CommentSerializer
  def initialize(comment)
    @comment = comment
  end

  def as_json
    {
      description: @comment.description,
      user: @comment.user.name
    }
  end
end
