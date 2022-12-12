Rails.application.routes.draw do
  devise_for :users
  resources :media

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get 'home/index'

  get 'home/search'
  post 'home/search'

  get 'home/about'
  get 'home/recommendations'
  get 'home/friends'
  get 'home/media'

  get 'createImdb', to: 'media#createImdb', as: 'createImdb'
  get 'showDetails', to: 'home#showDetails', as: 'showDetails'

  # for friends
  get 'friends/', to: 'friends#index', as: 'friends'
  post 'friends/', to: 'friends#index', as: 'friendsSearch'
  post 'addFriend/', to: 'friends#addFriend', as: 'addFriend'
end


