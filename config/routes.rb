Rails.application.routes.draw do
  root 'landing#index'

  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'dashboards#show'
  get '/directions', to: 'directions#index'

  get '/events/status', to: 'events#status'

  namespace :api do
    namespace :trails do
      resources :search, only: [:index]
    end
    resources :trails, only: [:index]
  end

  namespace :trails do
   resources :search, only: [:index]
   resources :select, only: [:index, :new]
  end

  namespace :admin do
    get '/', to: 'landing#index'
    resources :trails
    resources :users, only: [:index, :update, :destroy]
    resources :events
  end

  namespace :events do
    resources :search, only: [:index, :new]
  end


  resources :users, only: [:create, :show, :edit, :update]
  resources :trails, only: [:new, :create, :show, :edit, :update]
  resources :pictures
  resources :events, only: [:index, :new, :create, :show, :destroy]


end
