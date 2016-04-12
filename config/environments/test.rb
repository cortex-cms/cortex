Cortex::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.
  Dotenv.load

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure static asset server for tests with Cache-Control for performance.
  config.serve_static_files  = true
  config.static_cache_control = 'public, max-age=3600'

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr
  config.assets.image_optim = false

  config.cache_store = :redis_store, ENV['CACHE_URL'], { :namespace => 'cortex_test' }

  Fog.mock!

  Sidekiq.configure_server do |config|
    config.redis = { :namespace => 'cortex_test' }
  end

  Sidekiq.configure_client do |config|
    config.redis = { :namespace => 'cortex_test' }
  end

  config.action_mailer.default_url_options = {:host => ENV['HOST']}
  config.action_mailer.delivery_method = :test
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

  Paperclip::PaperclipOptimizer.default_options = { skip_missing_workers: true }
end
