Rails.application.routes.draw do
  resources :podcasts
  resources :games
  resources :tv_shows
  devise_for :users
  resources :movies
  resources :friends
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get 'home/about'
  get 'home/recommendations'
  get 'home/friends'

end
