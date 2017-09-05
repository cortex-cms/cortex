require 'sidekiq/web'

Cortex::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  root 'dashboards#index'

  scope '/admin_update' do
    match '/tenant_change', to: 'tenants#switch_tenants', via: [:post]
  end

  scope '/admin' do
    resources :dashboards
    resources :medias
  end

  resources :content_types do
    resources :content_items
  end

  scope :rss do
    scope :v2 do
      get ':content_type_name' => 'rss/v2/rss#index', as: 'rss_index', defaults: { format: 'rss' }
    end
  end

  # Authentication
  use_doorkeeper do
    unless Rails.env.development? && !ENV['DEPLOYED']
      skip_controllers :applications, :authorized_applications
    end
  end
  devise_for :users, controllers: {sessions: 'authentication/sessions', passwords: 'authentication/passwords'}

  # Sidekiq Admin
  authenticate :user, lambda { |u| u.is_admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # API
  ::API.logger Rails.logger
  mount ::API => '/api'

  # Flipper
  authenticated :user, lambda {|u| u.is_admin? } do
    flipper_block = lambda {
      Cortex.flipper
    }
    mount Flipper::UI.app(flipper_block) => '/flipper'
  end
end
