require "#{Rails.root}/app/api/v1/api"

Cortex::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  root 'home#index'

  get 'login', to: 'home#login'
  get 'login/reset_password', to: 'home#password_reset'
  post 'login/reset_password', to: 'home#submit_password_reset'

  # Authentication
  use_doorkeeper do
    unless Rails.env.development?
      skip_controllers :applications, :authorized_applications
    end
  end
  devise_for :users

  # Sidekiq Admin
  authenticate :user, lambda { |u| u.is_admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # API
  API::V1::API.logger Rails.logger
  mount API::V1::API => '/api'
end
