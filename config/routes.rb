Rails.application.routes.draw do
  root 'category#index'
  resources :welcome, only: [:index]
  resources :products, only: [:show]
  resources :category, only: [:index, :show]
  resources :submissions, only: [:new, :create]
  resources :users, only: [:new, :create]
  resources :user_sessions, only: [:new, :create, :destroy]
  namespace :admin do
    resources :base, only: [:index]
    resources :submissions, only: [:index, :edit, :update, :destroy]
    resources :products, only: [:index, :edit, :update]
  end
end
