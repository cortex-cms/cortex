require "#{Rails.root}/app/api/v1/api"

Cortex::Application.routes.draw do
  root :to => 'users#me'

  devise_for :users

  mount Sidekiq::Web => '/sidekiq'

  API::V1::API.logger Rails.logger
  mount API::V1::API => '/api'
end
