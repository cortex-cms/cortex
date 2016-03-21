module API
  module V1
    module Helpers
      module APIHelper
        def logger
          API.logger
        end

        # Authentication and Authorization
        def authenticate!
          unauthorized! unless current_user
        end

        def authorize!(action, subject)
          unless abilities.allowed?(current_user, action, subject)
            forbidden!
          end
        end

        def require_scope!(scopes)
          return unless find_access_token
          scopes = [scopes] unless scopes.kind_of? Array

          unless (find_access_token.scopes.to_a & scopes) == scopes
            # TODO: Scopes are historically completely broken in Cortex. This is quite the security issue: fix!
            puts 'SCOPES are currently being IGNORED'
            # forbidden!
          end
        end

        def current_tenant
          current_user.tenant
        end

        def can?(object, action, subject)
          abilities.allowed?(object, action, subject)
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

        private

        def abilities
          @abilities ||= begin
            abilities = Six.new
            abilities << Abilities::Ability
            abilities
          end
        end
      end
    end
  end
end
