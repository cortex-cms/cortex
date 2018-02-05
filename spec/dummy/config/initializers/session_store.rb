# Be sure to restart your server when you modify this file.

if ENV['DEPLOYED'] || Rails.env.production?
  Rails.application.config.session_store :redis_store, servers: ENV['SESSION_STORE_URL']
else
  Rails.application.config.session_store :redis_store, servers: ENV['SESSION_STORE_URL'], namespace: ENV['REDIS_NAMESPACE'] || 'cortex_starter_dev'
end
