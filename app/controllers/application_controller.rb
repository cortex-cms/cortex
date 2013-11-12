class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.d
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate

  private 
  	def authenticate
  		if user = authenticate_with_http_basic { |u, p| User.find_by_username_and_password(u, p) }
  			@current_user = user
      else
        request_http_basic_authentication
  		end
  	end
end
