class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  rescue_from Exception, with: :server_error
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render(nothing: true, status: 404)
  end

  def server_error(e)
    msg = e.try(:message) || "server error"
    render(json: { error_message: msg }, status: 500)
  end
  
end
