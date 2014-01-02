class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :authenticate
  before_action :require_login
  before_action :default_headers

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

    def default_headers
      headers['X-UA-Compatible'] = 'IE=edge'
    end
end
