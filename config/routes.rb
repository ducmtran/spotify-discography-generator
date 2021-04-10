Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'pages#welcome'

  get 'auth/spotify', to: 'pages#auth'
  get 'auth/spotify/callback', to: 'pages#home'
  get 'home', to: 'pages#home'
  get 'search_result', to: 'artists#search_result'
  get 'create_discography/:id', to: 'artists#create_discography', as: 'create_discography'
end
