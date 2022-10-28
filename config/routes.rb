Rails.application.routes.draw do
  devise_for :users
  resources :movies
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get 'home/about'
  get 'home/recommendations'
  get 'home/friends'

end
