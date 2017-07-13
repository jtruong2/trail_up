Rails.application.routes.draw do
  root 'landing#index'

  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'dashboards#show'

  namespace :api do
    resources :all_trails, only: [:index]
  end

  namespace :admin do
    get '/', to: 'landing#index'
    resources :trails
    resources :users
  end

  resources :users, only: [:create, :show]
  resources :trails, only: [:index, :new, :create, :show]
end
