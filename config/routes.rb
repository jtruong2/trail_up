Rails.application.routes.draw do
  root 'landing#index'
  get '/signup', to: 'users#new'
  get '/dashboard', to: 'dashboards#show'
  resources :users, only: [:create]
end
