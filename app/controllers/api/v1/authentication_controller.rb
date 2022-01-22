class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def authenticate
    command = AuthenticateUser.call(auth_params[:email], auth_params[:password])
    if command.success?
      render json: UserTokenSerializer.new(command.result).as_json, status: :ok
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
