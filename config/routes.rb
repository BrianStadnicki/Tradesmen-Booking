Rails.application.routes.draw do
  devise_for :users
  root to: 'jobs#index'
  resources :users
  resources :jobs
  resources :tradesmen_trades
  resources :tradesmen_profiles
  resources :businesses
  resources :businesses_tradesmen_profiles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
