Cortex::Application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

  resources :assets do
    get 'search', on: :collection
  end

  resources :posts
  resources :categories

  get 'organizations/:id', to: 'tenants#show'
  get 'tenants/hierarchy', to: 'tenants#hierarchy'
  resources :tenants

  get 'organizations/:org_id/tenants', to: 'tenants#by_organization'
  get 'organizations/:org_id/tenants/hierarchy', to: 'tenants#hierarchy_by_organization'
  resources :organizations

  get 'users/me', to: 'users#me'
  resources :users


end