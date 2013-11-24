Cortex::Application.routes.draw do

  resources :tenants

  resources :organizations

  get 'users/me', to: 'users#me'
  resources :users

end