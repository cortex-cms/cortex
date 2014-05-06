class ApplicationController < ActionController::Base
  before_action :default_headers
  before_action :authenticate_user!
  before_action :add_gon
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery

  protected

  def default_headers
    headers['X-UA-Compatible'] = 'IE=edge'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :tenant_id
  end

  private

  def add_gon
    gon.push({
      :current_user => current_user,
      :settings => {
        :cortex_base_url => "#{request.protocol}#{request.host_with_port}/api/v1"
      }
    })
  end
end
