class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :authenticate
  before_action :require_login
  before_action :default_headers
  rescue_from Exception, with: :handle_exception

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

    def handle_exception(exception)
      if exception.kind_of? Exceptions::CortexAPIError
        render json: {message: exception.message}, http_status: exception.http_status
      elsif Rails.env != 'development'
        render json: {message: 'Internal server error'}, http_status: :internal_server_error
      end
    end
end
