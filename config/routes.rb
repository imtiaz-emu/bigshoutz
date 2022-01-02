Rails.application.routes.draw do
  devise_for :users

  get 'dashboard' => 'dashboard#index'

  resources :profiles, only: %i[show edit update] do
    member do
      patch 'update_password'
    end
  end

  resources :services
  resources :listings

  root 'home#index'
end
