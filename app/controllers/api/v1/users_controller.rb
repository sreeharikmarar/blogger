class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request

  def create
    user = User.create(user_params)
    if user.save
      render json: UserSerializer.new(user).as_json, status: :created
    else
      render json: { error: user.errors.full_messages.first }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
