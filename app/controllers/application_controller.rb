class ApplicationController < ActionController::Base
  include Exceptions

  protect_from_forgery with: :null_session
  before_action :authenticate!
  before_action :default_headers

  rescue_from Exception, with: :handle_exception

  def log_in(user)
    @current_user = user
  end

  def current_user
    @current_user
  end

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
    user = authenticate_with_http_basic { |username, password| User.authenticate(username, password) }
    log_in(user) if user
  end

  def authenticate!
    authenticate || unauthorized!
  end

  def default_headers
    headers['X-UA-Compatible'] = 'IE=edge'
  end

  def log_exception(exception)
    logger.error "\n#{exception.class.name} (#{exception.message}):\n#{exception.backtrace.join}"
  end

  private

  def handle_exception(exception)
    if [ActiveRecord::RecordNotFound,
        ActiveRecord::RecordInvalid,
        ActionController::UnknownController,
        AbstractController::ActionNotFound].include? exception.class
      raise
    else
      if exception.kind_of? Exceptions::CortexAPIError
        render_api_error!(exception.message, exception.http_status)
      elsif Rails.env != 'development'
        log_exception(exception)
        server_error!
      end
    end
  end
end
