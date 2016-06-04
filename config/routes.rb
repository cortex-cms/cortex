Cortex::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  root 'dashboards#index'
  get 'legacy', to: 'legacy#index', as: :legacy_root

  scope '/admin' do
    resources :dashboards
    resources :medias
  end

  # Authentication
  use_doorkeeper do
    unless Rails.env.development? && !ENV['DEPLOYED']
      skip_controllers :applications, :authorized_applications
    end
  end
  devise_for :users, controllers: {sessions: 'authentication/sessions'}

  # Sidekiq Admin
  authenticate :user, lambda { |u| u.is_admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # API
  ::API.logger Rails.logger
  mount ::API => '/api'
end
