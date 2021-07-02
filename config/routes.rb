Rails.application.routes.draw do
  root to: 'questions#index'
  resources :users
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :questions do
    collection do
      get :solved
      get :unsolved
    end

    member do
      post :solve
    end

    resources :answers
  end

  resources :users, only: [:index]

  namespace :admin do
    resources :users, only: [:index, :destroy]
    resources :questions, only: [:index, :destroy]
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
