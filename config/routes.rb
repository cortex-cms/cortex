require "#{Rails.root}/app/api/v1/api"

Cortex::Application.routes.draw do
  root 'home#index'

  get 'login', to: 'home#login'

  # Authentication
  use_doorkeeper
  devise_for :users

  # Sidekiq Admin
  authenticate :user, lambda { |u| u.is_admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # API
  API::V1::API.logger Rails.logger
  mount API::V1::API => '/api'
end
