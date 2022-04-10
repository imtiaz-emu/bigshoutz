# == Route Map
#

Rails.application.routes.draw do
  devise_for :users
  scope '/admin' do
    resources :users, only: %i[new create]
  end

  resources :profiles, only: %i[show edit update] do
    member do
      patch 'update_password'
    end
  end

  resources :services
  resources :addons

  resources :listings do
    resources :votes, only: %i[create update destroy]
    resources :comments, only: %i[create update destroy edit]
  end

  resources :dashboard, only: %i[index] do
    collection do
      get 'listings'
      get 'users'
      get 'services'
      get 'addons'
    end
  end

  root 'home#index'
end
