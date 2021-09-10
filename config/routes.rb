Rails.application.routes.draw do
  get '/service-worker.js' => "service_worker#service_worker"
  get '/manifest.json' => "service_worker#manifest"
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
  root to: 'jobs#mine_active'
  resources :users do
    resources :notifications
    get 'current_id', on: :collection
  end
  resources :jobs do
    resources :job_tradesmen_applications
    get 'mine', on: :collection
    get 'mine_active', on: :collection
    get 'applicable', on: :collection
    get 'completed', on: :collection
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
