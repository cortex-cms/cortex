class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.d
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :authenticate

  def log_in(user)
    @current_user = user
  end

  private
    def authenticate
      if user = authenticate_with_http_basic { |username, password| User.authenticate(username, password) }
        log_in(user)
      end
    end

    def require_login
      if !@current_user
        # TODO: Replace with thrown exception + exception handling returning meaningful data
        render :status => :unauthorized, :json => {}
      end
    end
end
