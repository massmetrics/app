Rails.application.routes.draw do
  root 'welcome#index'
  resources :welcome, only: [:index]
  resources :product, only: [:show]
  resources :category
end
