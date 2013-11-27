class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.d
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_organization, :authenticate

  private
    def set_organization
      @organization = Organization.find_by(subdomain: request.subdomains.first)
    end

  	def authenticate
  		if user = authenticate_with_http_basic { |u, p| User.find_by_name_and_password(u, p) }
  			@current_user = user
      end
  	end
end
