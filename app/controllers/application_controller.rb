class ApplicationController < ActionController::Base
  include Exceptions

  protect_from_forgery
  before_action :default_headers
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Exception, with: :handle_exception

  protected

  def default_headers
    headers['X-UA-Compatible'] = 'IE=edge'
  end

  def log_exception(exception)
    logger.error "\n#{exception.class.name} (#{exception.message}):\n#{exception.backtrace.join}"
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :tenant_id
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
