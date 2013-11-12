Cortex::Application.routes.draw do

  resources :tenants

  resources :platform_admins

  resources :organizations

  get 'users/me', to: 'users#me'
  resources :users

end