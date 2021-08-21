Rails.application.routes.draw do
  get 'business_tradesmen_profile/create'
  get 'business_tradesmen_profile/destroy'
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    invitations: 'users/invitations',
    omniauth: 'users/omniauth_callbacks',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }
  root to: 'jobs#index'
  resources :users
  resources :jobs do
    resources :job_tradesmen_applications
  end
  resources :tradesmen_trades
  resources :tradesmen_profiles do
    get 'trusted', on: :collection
  end
  resources :businesses do
    get 'trusted', on: :collection
  end
  resources :businesses_tradesmen_profile
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
