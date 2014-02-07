Cortex::Application.routes.draw do
  root :to => 'users#me'

  devise_for :users

  mount Sidekiq::Web => '/sidekiq'

  resources :media do
    get 'search', on: :collection
  end

  resources :posts

  get 'categories/hierarchy', to: 'categories#hierarchy'
  resources :categories

  get 'tenants/hierarchy', to: 'tenants#hierarchy'
  get 'tenants/:id/tenants', to: 'tenants#tenant_tenants'
  get 'tenants/:id/hierarchy', to: 'tenants#tenant_hierarchy'
  resources :tenants

  get 'users/me', to: 'users#me'
  resources :users
end
