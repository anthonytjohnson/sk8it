Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :spots, only: [:index, :show, :new, :create] do
    resources :videos, only: [:new, :create]
    resources :reviews, only: [:create]
    resources :favorites, only: [:create]
  end

  resources :users, only: [:show, :update] do
    member do
      get :profile
    end
  end

  namespace :dashboard do
    resources :videos, only: [:index]
  end

  resources :videos, only: [:update] do
    resources :comments, only: [:create]
  end

  get '/videos/:id/upvote', to: 'videos#upvote', as: 'upvote'
end
