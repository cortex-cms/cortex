Cortex::Application.routes.draw do

  resources :assets

  get 'tenants/hierarchy', to: 'tenants#hierarchy'
  resources :tenants

  get 'organizations/:org_id/tenants', to: 'tenants#by_organization'
  get 'organizations/:org_id/tenants/hierarchy', to: 'tenants#hierarchy_by_organization'
  resources :organizations

  get 'users/me', to: 'users#me'
  resources :users

end