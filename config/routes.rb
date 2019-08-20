Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'pages#welcome'

  get 'auth', to: 'users#oauth'
  get 'auth/callback', to: 'pages#redirect_to_home'
  get 'home', to: 'pages#home'
  get 'search_result', to: 'artists#search_result'
  get 'create_playlist/:id', to: 'artists#create_playlist', as: 'create_playlist'
end
