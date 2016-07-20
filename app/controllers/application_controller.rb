class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :default_headers
  before_action :configure_permitted_parameters, if: :devise_controller?
  respond_to :html, :json
  add_flash_types :success, :warning, :danger, :info

  protected

  def default_headers
    headers['X-UA-Compatible'] = 'IE=edge'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:tenant_id])
  end
end
