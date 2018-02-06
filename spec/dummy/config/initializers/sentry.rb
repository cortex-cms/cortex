if defined? Raven
  Raven.configure do |config|
    config.dsn = ENV['SENTRY_RAVEN_DSN']
    config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
  end
end
