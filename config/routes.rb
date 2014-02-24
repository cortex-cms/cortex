require "#{Rails.root}/app/api/v1/api"

Cortex::Application.routes.draw do

  # Hack to point root URL to API
  root :controller => :static, :action => '/api/v1/users/me'

  # Authentication
  use_doorkeeper
  devise_for :users

  # Sidekiq Admin
  mount Sidekiq::Web => '/sidekiq'

  # API
  API::V1::API.logger Rails.logger
  mount API::V1::API => '/api'
end
