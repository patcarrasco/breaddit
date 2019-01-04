Rails.application.routes.draw do
  resources :users, only: %i[new create edit update delete]
  resources :posts
  resources :sessions, only: %i[new create]
  resources :comments, only: %i[create]

  get '/', to: "posts#index"

  get '/home', to: "posts#home"

  get '/comment', to: "posts#index"

  get '/sessions/account', to: "sessions#account", as: 'account'

  get '/sessions/', to: "sessions#new"

  post '/posts/support/:id', to: "posts#support", as: "support"

  post '/users/follow/:id', to: "users#follow", as: "follow"

  delete '/sessions/delete', to: "sessions#delete"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
