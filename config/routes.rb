require 'sidekiq/web'
require 'flipper/ui'

Cortex::Engine.routes.draw do
  # API - TODO: Authorize GraphQL + GraphiQL
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: ENV['GRAPHQL_URL'], as: 'graphiql'
  scope '/graphql' do
    post '/', to: 'graphql#execute'
    get '/ide', to: 'graphql#ide', as: 'graphql_ide'
  end

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

  # Authentication
  devise_for :users, controllers: {sessions: 'cortex/authentication/sessions', passwords: 'cortex/authentication/passwords'}, class_name: 'Cortex::User', module: :devise

  # Sidekiq Admin TODO: this needs to be updated with new role system
  #authenticate :user, lambda { |u| u.is_admin? } do
  mount Sidekiq::Web => '/sidekiq'
  #end

  # Flipper TODO: this needs to be updated with new role system
  #authenticated :user, lambda {|u| u.is_admin? } do
  mount Flipper::UI.app(Flipper) => '/flipper'
  #end

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
end
