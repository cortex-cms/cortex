class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.d
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :set_organization, :authenticate

  private
    def set_organization
      #@organization = Organization.find_by(subdomain: request.subdomain.first)
    end

  	def authenticate
  		if user = authenticate_with_http_basic { |u, p| User.find_by_name_and_password(u, p) }
  			@current_user = user
      else
        request_http_basic_authentication
      end
  	end
end
