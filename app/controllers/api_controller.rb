class ApiController < ApplicationController
  before_filter :authenticate!

  # Error Rendering
  def not_found!
    render_api_error!('(404) Not Found', 404)
  end

  def unauthorized!
    render_api_error!('(401) Unauthorized', 401)
  end

  def forbidden!
    render_api_error!('(403) Forbidden', 403)
  end

  def bad_request!
    render_api_error!('(400) Bad Request', 400)
  end

  def not_allowed!
    render_api_error!('(405) Method Not Allowed', 405)
  end

  def server_error!
    render_api_error!('(500) Internal Server Error', 500)
  end

  def render_api_error!(message, status)
    render json: {message: message}, status: status
  end

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      user = User.authenticate(username, password)
      if user
        sign_in user
      end
    end
  end

  def authenticate!
    current_user || authenticate || unauthorized!
  end
end
