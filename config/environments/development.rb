Cortex::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.
  Dotenv.load

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  #config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  config.cache_store = :memory_store

  if ENV['S3_BUCKET_NAME'].to_s != ''
    config.paperclip_defaults = {
      :storage => :s3,
      :s3_credentials => {
        :bucket => ENV['S3_BUCKET_NAME'],
        :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
        :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
        :url => ':s3_alias_url',
        :s3_host_alias => ENV['S3_HOST_ALIAS']
      }
    }
  else
    Paperclip.options[:command_path] = "/usr/local/bin/"
    config.paperclip_defaults = {
      storage: :fog,
      fog_host: ENV['HOST'],
      fog_directory: '',
      fog_credentials: {
        provider: 'Local',
        local_root: "#{Rails.root}/public"
      }
    }
  end

  Sidekiq.configure_server do |config|
    config.redis = { :namespace => ENV['REDIS_NAMESPACE'] || 'cortex_dev' }
  end

  Sidekiq.configure_client do |config|
    config.redis = { :namespace => ENV['REDIS_NAMESPACE'] || 'cortex_dev' }
  end

  silence_warnings do
    begin
      require 'pry'
      IRB = Pry
    rescue LoadError
    end
  end
end
