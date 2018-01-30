require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module CortexStarter
  class Application < Rails::Application
    config.load_defaults 5.1

    config.i18n.enforce_available_locales = true

    config.active_record.default_timezone = :utc
    config.active_job.queue_adapter = :sidekiq

    # Generators should use UUID PKs by default
    config.generators do |generator|
      generator.orm :active_record, primary_key_type: :uuid
    end
  end
end
