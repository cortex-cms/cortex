if defined? Raven
  Raven.configure do |config|
    config.dsn = ENV['SENTRY_RAVEN_DSN']
  end
end
