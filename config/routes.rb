Rails.application.routes.draw do
  resources :podcasts
  resources :games
  resources :tv_shows
  devise_for :users
  resources :movies
  resources :friends
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  post 'home/index'
  get 'home/index'
  get 'home/about'
  get 'home/recommendations'
  get 'home/friends'

  get 'showImdb', to: 'movies#showImdb', as: 'movie_showImdb'
  get 'addImdb', to: 'movies#addImdb', as: 'movie_addImdb'

end
