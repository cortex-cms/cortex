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

    def set_pagination_params(per_page=25)
      @per_page = params[:per_page] || per_page
      @page = params[:page] || 1
    end

    def set_pagination_results(resource, results, per_page)
      return unless results.count > 0

      count = results.count
      current_page = results.current_page
      total_pages = results.total_pages

      page_start = (current_page - 1) * per_page + 1
      page_end = (current_page - 1) * per_page + count

      page = {}
      page[:first] = 1 if total_pages > 1
      page[:last] = results.num_pages if total_pages > 1
      page[:next] = current_page + 1 unless results.last_page?
      page[:prev] = current_page - 1 if (total_pages > 1 && current_page > 1)

      resource_name = resource.name.downcase.pluralize
      headers[:'Accept-Ranges'] = resource_name
      headers[:'Content-Range'] = "#{resource_name} #{page_start}-#{page_end}/#{count}"
    end
end
