Rails.application.routes.draw do
  root 'category#index'
  resources :welcome, only: [:index]
  resources :product, only: [:show]
  resources :category
  resources :submissions
  resources :users
  resources :user_sessions
end
