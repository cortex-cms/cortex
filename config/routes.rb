Cortex::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  root 'dashboards#index'
  get 'legacy', to: 'legacy#index'

  scope '/admin' do
    resources :dashboards
    resources :medias
  end

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
