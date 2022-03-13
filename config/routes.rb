Rails.application.routes.draw do
  devise_for :users

  resources :profiles, only: %i[show edit update] do
    member do
      patch 'update_password'
    end
  end

  resources :services
  resources :listings do
    resources :votes, only: %i[create update destroy]
    resources :comments, only: %i[create update destroy edit]
  end

  resources :dashboard, only: %i[index] do
    collection do
      get 'listings'
      get 'users'
      get 'services'
    end
  end

  root 'home#index'
end
