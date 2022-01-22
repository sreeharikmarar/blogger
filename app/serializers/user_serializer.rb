# frozen_string_literal: true

class UserSerializer
  def initialize(user)
    @user = user
  end

  def as_json
    {
      name: @user.name,
      email: @user.email
    }
  end
end
