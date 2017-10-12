require_relative 'boot'

require 'rails/all'
require 'elasticsearch/rails/instrumentation'

Bundler.require(*Rails.groups)

module Cortex
  class Application < Rails::Application
    config.load_defaults 5.1

    config.i18n.enforce_available_locales = true

    config.eager_load_paths += %W(#{config.root}/lib #{config.root}/lib/helpers #{config.root}/lib/breadcrumbs)

    config.active_record.default_timezone = :utc
    config.active_job.queue_adapter = :sidekiq
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')

    # Insert Rack::CORS as the first middleware
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins *((Cortex.config.cors.allowed_origins || '*').split(',') +
                  [Cortex.config.cors.allowed_origins_regex || ''])
        resource '*',
                 :headers => :any,
                 :expose  => %w(Content-Range Link),
                 :methods => [:get, :post, :options, :put, :patch, :delete]
      end
    end

    # Generators should use UUID PKs by default
    config.generators do |generator|
      generator.orm :active_record, primary_key_type: :uuid
    end
  end
end
