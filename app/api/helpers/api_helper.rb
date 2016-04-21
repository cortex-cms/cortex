module Helpers
  module APIHelper
    def logger
      ::API.logger
    end

    def current_tenant
      current_user.tenant
    end

    # API Errors
    def bad_request!
      render_api_error!('(400) Bad Request', 400)
    end

    def forbidden!
      render_api_error!('(403) Forbidden', 403)
    end

    def not_found!
      render_api_error!('(404) Not found', 404)
    end

    def unauthorized!
      render_api_error!('(401) Unauthorized', 401)
    end

    def render_api_error!(message, status)
      error!({message: message}, status)
    end
  end
end
