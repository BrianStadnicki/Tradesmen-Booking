Rails.application.routes.draw do
  devise_for :users
  root to: 'jobs#index'
  scope '/admin' do
    resources :users
  end
  resources :jobs
  resources :tradesmen_trades
  resources :tradesmen_profiles
  resources :businesses
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
