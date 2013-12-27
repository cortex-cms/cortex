require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'apartment/elevators/subdomain'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Cortex
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    ActsAsTaggableOn.remove_unused_tags = true
    ActsAsTaggableOn.force_lowercase = true

    config.middleware.use 'Apartment::Elevators::Generic', Proc.new { |request| determine_subdomain(request)  }
    config.active_record.default_timezone = :utc

    config.middleware.insert_before Rack::Lock, Rack::Cors do
      allow do
        origins *APP_CONFIG['allowed_origins']
        resource '*', :headers => :any, :methods => [:get, :post, :options, :put, :patch, :delete]
      end
    end

    private
      def determine_subdomain(request)
        #return subdomain(request.host) || APP_CONFIG['default_subdomain']
        #Restore once we get a domain name and can assign subdomains! MAIMING THE CONFIG
        return APP_CONFIG['default_subdomain']
      end

      def subdomain(host)
        subdomains(host).first
      end

      def subdomains(host, tld_length = 1)
        return [] unless named_host?(host)
        host.split('.')[0..-(tld_length + 2)]
      end

      def named_host?(host)
        !(host.nil? || /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/.match(host))
      end
  end
end
