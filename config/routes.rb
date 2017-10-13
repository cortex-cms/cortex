require 'sidekiq/web'

Cortex::Application.routes.draw do
  # API - TODO: Authorize GraphQL + GraphiQL
  post '/graphql', to: 'graphql#execute'
  get '/graphiql', to: 'graphiql#embed', as: 'graphiql_embed'

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
  devise_for :users, controllers: {sessions: 'authentication/sessions', passwords: 'authentication/passwords'}

  # Sidekiq Admin TODO: this needs to be updated with new role system
  #authenticate :user, lambda { |u| u.is_admin? } do
  #  mount Sidekiq::Web => '/sidekiq'
  #end

  # Flipper TODO: this needs to be updated with new role system
  #authenticated :user, lambda {|u| u.is_admin? } do
    flipper_block = lambda {
      Cortex.flipper
    }
    mount Flipper::UI.app(flipper_block) => '/flipper'
  #end

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
end
