class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  rescue_from ActionController::RoutingError, with: :routing_error
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def render_ok(content = {})
    render json: content, status: :ok
  end

  def render_error(status, content = { reason: :unexpected_error })
    render json: content, status: status
  end

  private
  
  def routing_error
    render_error(:bad_request, reason: :bad_request)
  end

  def record_not_found
    render_error(:not_found, reason: :not_found)
  end
end
