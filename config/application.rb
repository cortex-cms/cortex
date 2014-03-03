require File.expand_path('../boot', __FILE__)
require 'rails/all'
Bundler.require(:default, Rails.env)

module Cortex
  class Application < Rails::Application
    config.i18n.enforce_available_locales = true

    config.autoload_paths += %W(#{config.root}/lib)
    
    ActsAsTaggableOn.remove_unused_tags = true
    ActsAsTaggableOn.force_lowercase = true

    config.active_record.default_timezone = :utc

    # Insert Rack::CORS as one of the first middleware
    config.middleware.insert_after Rack::Sendfile, Rack::Cors do
      allow do
        origins *AppSettings.allowed_origins
        resource '*',
                 :headers => :any,
                 :expose  => %w(Content-Range Link),
                 :methods => [:get, :post, :options, :put, :patch, :delete]
      end
    end

    require 'rack/oauth2'
    config.middleware.use Rack::OAuth2::Server::Resource::Bearer, 'OAuth2' do |request|
      Doorkeeper::AccessToken.authenticate(request.access_token) || request.invalid_token!
    end

    TireAsyncIndex.configure do |config|
      config.background_engine :sidekiq
      config.use_queue :default
    end
  end
end
