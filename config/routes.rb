Cortex::Application.routes.draw do

  get 'tenants/hierarchy', to: 'tenants#hierarchy'
  resources :tenants

  resources :organizations

  get 'users/me', to: 'users#me'
  resources :users

end