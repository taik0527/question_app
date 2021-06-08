Rails.application.routes.draw do
  namespace :admin do
    get 'users/index'
    get 'questions/index'
  end
  root to: 'users#index'
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
