Myflix::Application.routes.draw do
  root to: 'pages#front'
  get '/home', to: 'videos#index'

  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'

  resources :videos, only: [:index, :show] do
    collection do
      get :search, to: 'videos#search'
    end
  end
  resources :users, only: [:create]
  resources :sessions, only: [:create]
  resources :reviews, only: [:create]
  
  get '/genres/:id', to: 'categories#show', as: :category
  get 'ui(/:action)', controller: 'ui'
end
