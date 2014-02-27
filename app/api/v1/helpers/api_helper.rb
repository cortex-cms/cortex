module API::V1
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
        return unless current_token
        scopes = [scopes] unless scopes.kind_of? Array

        unless (current_token.application.scopes & scopes) == scopes
          forbidden!
        end
      end

      def current_token
        env['api.token']
      end

      def current_user
        @current_user ||= warden_current_user || find_current_user
      end

      def current_user!
        current_user.anonymous? ? unauthorized! : current_user
      end

      # Gross, move to central authorization lib during OAuth implementation
      def find_current_user
        # OAuth
        if current_token
          User.find(current_token.resource_owner_id)
        # Basic Auth
        else
          req = Rack::Auth::Basic::Request.new(env)
          unless req.provided? and req.basic?
            return User.anonymous
          end
          login, password = req.credentials

          User.authenticate(login, password) || User.anonymous
        end
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

      def warden
        @warden ||= env['warden']
      end

      def warden_current_user
        warden ? warden.user : nil
      end

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
