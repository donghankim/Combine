Rails.application.routes.draw do
  devise_for :users
  resources :media, :except => :edit
  # resources :friends

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get 'home/index'

  get 'home/search'
  post 'home/search'

  get 'home/about'
  get 'home/recommendations'
  get 'home/media'

  # for media
  get 'createImdb', to: 'media#createImdb', as: 'createImdb'
  get 'showDetails', to: 'home#showDetails', as: 'showDetails'

  # for friends
  get 'friends', to: 'friends#index', as: 'friends'
  get 'addFriend', to: 'friends#addFriend', as: 'addFriend'
  post 'friends', to: 'friends#index', as: 'friendsSearch'
  get '/friend/:id(.:format)', to: 'friends#show', as: 'showFriend'
  delete '/friend/:id(.:format)', to: 'friends#destroy', as: 'removeFriend'

end
