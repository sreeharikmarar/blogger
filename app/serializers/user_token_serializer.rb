# frozen_string_literal: true

class UserTokenSerializer
  def initialize(token)
    @token = token
  end

  def as_json
    {
      token: @token
    }
  end
end
