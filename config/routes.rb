Rails.application.routes.draw do
  devise_for :users

  resources :profiles, only: %i[show edit update] do
    member do
      patch 'update_password'
    end
  end

  resources :services
  resources :listings
  resources :dashboard, only: %i[index] do
    collection do
      get 'listings'
      get 'users'
      get 'services'
    end
  end

  root 'home#index'
end
