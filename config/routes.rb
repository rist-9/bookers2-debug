Rails.application.routes.draw do
  get 'home/about'
  devise_for :users
  resources :books
  resources :users,only: [:show,:index,:edit,:update]
  root 'home#top'
  get 'users/about' => 'books#about'
end