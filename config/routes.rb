Rails.application.routes.draw do
  resources :password_resets
  root to: "category#index"
  resources :products, only: [:show] do
    resources :my_products, only: [:create, :destroy]
  end
  get 'about' => 'welcome#about'
  resources :my_products_notifications, only: [:create, :destroy]
  resources :category, only: [:index, :show]
  resources :submissions, only: [:new, :create]
  resources :users, only: [:new, :create, :show]
  resources :user_sessions, only: [:new, :create, :destroy]
  namespace :admin do
    resources :base, only: [:index]
    resources :submissions, only: [:index, :edit, :update, :destroy]
    resources :products
  end
end
