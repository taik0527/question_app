Rails.application.routes.draw do
  root to: 'questions#index'
  namespace :admin do
    get 'users', to: 'users#index'
    get 'questions', to: 'questions#index'
    delete 'questions/:id', to: 'questions#destroy'
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'users/:id', to: 'users#destroy'
  end
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/questions/solved', to: 'questions#solved'
  get '/questions/unsolved', to: 'questions#unsolved'
  resources :users
  resources :questions
  resources :questions do
    resources :answers
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
