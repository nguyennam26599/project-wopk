# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: { registrations: 'registrations' }
  devise_for :admins
  resources :follow_polymorphics
  # routes create post function
  resources :posts
  resources :tags do
    collection do
      get :search
    end
  end
  # end
  resources :users, only: %w[update show edit]
  devise_scope :user do
    get 'login', to: 'users/sessions#new'
    get 'signup', to: 'users/registrations#new'
  end
  namespace :admins do
    root 'pages#index'
    # CRUD tags admin
    resources :tags
    # end
  end
  get 'confirm', to: 'home#confirm_pages'
end
