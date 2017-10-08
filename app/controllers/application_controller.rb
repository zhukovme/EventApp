class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  rescue_from ActionController::RoutingError, with: :routing_error
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def render_200(content = {})
    render json: content, status: 200
  end

  def render_400(content = { reason: "bad_request" })
    render json: content, status: 400
  end

  def render_404(content = { reason: "not_found" })
    render json: content, status: 404
  end

  def render_500(content = { reason: "internal_server_error" })
    render json: content, status: 500
  end

  private
  def routing_error
    render_404
  end

  def record_not_found
    render_404
  end

end
