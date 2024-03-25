Rails.application.routes.draw do
  root 'users#new'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :users, only: [:new, :create]
  resources :blogs, only: [:index]

  # API routes
  namespace :api do
    namespace :v1 do
      post 'login', to: 'sessions#create'
      post 'register', to: 'users#create'
      resources :blogs, only: [:index, :create]
    end
  end
end
