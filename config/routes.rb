# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  get '/tagfeed', to: 'home#tagfeed'
  get '/timeline', to: 'home#timeline'
  get '/milestones', to: 'home#milestones'
  get '/confirm', to: 'home#confirm_pages'

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
    get 'users/reset', to: 'users/registrations#edit'
  end
  namespace :admins do
    root 'pages#index'
    # CRUD tags admin
    resources :tags
    resources :users
    # end
    # Post admin
    resources :posts
    # end
  end
  get 'confirm', to: 'home#confirm_pages'
  get 'tags/show'
end
