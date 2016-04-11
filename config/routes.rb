Cortex::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  root 'home#index'

  get 'login', to: 'home#login'
  get 'login/reset_password', to: 'home#password_reset'
  post 'login/reset_password', to: 'home#submit_password_reset'

  # Authentication
  use_doorkeeper do
    unless Rails.env.development? && !ENV['DEPLOYED']
      skip_controllers :applications, :authorized_applications
    end
  end
  devise_for :users

  # Sidekiq Admin
  authenticate :user, lambda { |u| u.is_admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # API
  ::API.logger Rails.logger
  mount ::API => '/api'
end
