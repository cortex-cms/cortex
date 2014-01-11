class ApplicationController < ActionController::Base
  include Exceptions

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
      user = authenticate_with_http_basic { |username, password| User.authenticate(username, password) }
      log_in(user) if user
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
      unless [ActiveRecord::RecordNotFound,
              ActiveRecord::RecordInvalid,
              ActionController::UnknownController,
              AbstractController::ActionNotFound].include? exception.class
        begin
          if exception.kind_of? Exceptions::CortexAPIError
            render json: { message: exception.message }, status: exception.http_status
          elsif Rails.env != 'development'
            logger.error exception.message
            logger.error exception.backtrace.join("\n")
            render json: { message: 'Internal server error' }, status: :internal_server_error
          end
        rescue
          # all hell has broken loose, don't do anything
        end
      else
        # raise exception again for modules/gems that handle their own errors
        raise
      end
    end
end
