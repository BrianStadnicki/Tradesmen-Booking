Rails.application.routes.draw do
  get 'business_tradesmen_profile/create'
  get 'business_tradesmen_profile/destroy'
  devise_for :users
  root to: 'jobs#index'
  resources :users
  resources :jobs
  resources :tradesmen_trades
  resources :tradesmen_profiles do
    get 'trusted', on: :collection
  end
  resources :businesses
  resources :businesses_tradesmen_profile
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
