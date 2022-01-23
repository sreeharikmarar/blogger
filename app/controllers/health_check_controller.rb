class HealthCheckController < ActionController::API
  def ping
    render json: { success: true, errors: nil, data: 'pong' }, status: :ok
  end
end
