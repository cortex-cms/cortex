Cortex::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
  config.assets.quiet = true

  # config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  if ENV['DEPLOYED']
    config.cache_store = :redis_store, ENV['CACHE_URL']
  else
    config.cache_store = :redis_store, ENV['CACHE_URL'], { :namespace => ENV['REDIS_NAMESPACE'] || 'cortex_dev' }
  end

  Sidekiq.configure_server do |config|
    config.redis = { :namespace => ENV['REDIS_NAMESPACE'] || 'cortex_dev' } unless ENV['DEPLOYED']
  end

  Sidekiq.configure_client do |config|
    config.redis = { :namespace => ENV['REDIS_NAMESPACE'] || 'cortex_dev' } unless ENV['DEPLOYED']
  end

  config.action_mailer.default_url_options = {:host => ENV['HOST']}
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :authentication => :login,
    :address => ENV['SMTP_ADDRESS'],
    :port => ENV['SMTP_PORT'],
    :domain => ENV['SMTP_SENDER_DOMAIN'],
    :user_name => ENV['SMTP_USERNAME'],
    :password => ENV['SMTP_PASSWORD'],
    :enable_starttls_auto => ENV['SMTP_STARTTLS']
  }
  ActionMailer::Base.default from: ENV['SMTP_SENDER_ADDRESS']
end
