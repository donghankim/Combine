Rails.application.routes.draw do
  devise_for :users
  resources :podcasts
  resources :games
  resources :tv_shows
  resources :movies
  resources :friends
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  post 'home/index'
  get 'home/index'
  get 'home/about'
  get 'home/recommendations'
  get 'home/friends'
  get 'home/test'
  get 'home/media'

  get 'showImdb', to: 'home#showImdb', as: 'showImdb'
  get 'addImdbMovie', to: 'movies#addImdb', as: 'movie_addImdb'
  get 'addImdbSeries', to: 'tv_shows#addImdb', as: 'tv_show_addImdb'
  get 'addImdbGame', to: 'games#addImdb', as: 'game_addImdb'
end

