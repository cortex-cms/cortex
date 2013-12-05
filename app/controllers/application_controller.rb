class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.d
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :authenticate

  private
    def authenticate
      if user = authenticate_with_http_basic { |username, password| User.authenticate(username, password) }
        @current_user = user
      else
        request_http_basic_authentication
      end
    end
end
