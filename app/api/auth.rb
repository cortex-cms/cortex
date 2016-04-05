require 'doorkeeper/grape/authorization_decorator'

module Auth
  extend ActiveSupport::Concern

  included do
    use Rack::OAuth2::Server::Resource::Bearer, 'OAuth2' do |request|
      # Yield access token to store it in the env
      request.access_token
    end

    helpers HelperMethods
  end

  module HelperMethods
    def current_user
      @current_user ||= find_current_user
    end

    def current_user!
      current_user.anonymous? ? unauthorized! : current_user
    end

    def find_access_token
      @access_token ||= Doorkeeper.authenticate(doorkeeper_request, Doorkeeper.configuration.access_token_methods)
    end

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

    def can?(object, action, subject)
      abilities.allowed?(object, action, subject)
    end

    private

    def abilities
      @abilities ||= begin
        abilities = Six.new
        abilities << Abilities::Ability
        abilities
      end
    end

    def find_current_user
      if find_access_token
        lookup_owner
      elsif warden_current_user
        warden_current_user
      else
        User.anonymous
      end
    end

    def lookup_owner
      if find_access_token.resource_owner_id.present?
        User.find_by_id(find_access_token.resource_owner_id)
      else
        find_access_token.application.owner
      end
    end

    def doorkeeper_request
      @doorkeeper_request ||= Doorkeeper::Grape::AuthorizationDecorator.new(request)
    end

    def warden
      @warden ||= env['warden']
    end

    def warden_current_user
      warden ? warden.user : nil
    end
  end
end
