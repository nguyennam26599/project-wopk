# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /en|vi/ do
    root 'home#index'
    get '/tagfeed', to: 'home#tagfeed'
    get '/timeline', to: 'home#timeline'
    get '/milestones', to: 'home#milestones'
    get '/confirm', to: 'home#confirm_pages'

    devise_for :users, controllers: { registrations: 'registrations' }
    devise_for :admins
    resources :follow_polymorphics
    # routes create post function
    resources :posts do
      member do
        post :view
        put :clip, to: 'follow_polymorphics#clip'
        put 'vote', to: 'post_votings#vote'
      end
    end

    resources :tags do
      collection do
        get :search
      end
    end
  end
  # end

  devise_scope :user do
    get 'login', to: 'users/sessions#new'
    get 'signup', to: 'users/registrations#new'
    get 'user/password', to: 'users/registrations#edit', as: 'password'
    get 'user/password', to: 'users/registrations#edit'
    get 'users/public', to: 'users#show_post_public'
    get 'users/draft', to: 'users#show_post_draft'
    get 'users/pending', to: 'users#show_post_pending'
    get 'users/close', to: 'users#show_post_close'
  end
  get 'user/profile', to: 'users#edit', as: 'profile'
  resources :users, only: %w[update show]
  namespace :admins do
    root 'pages#index'
    # CRUD tags admin
    resources :tags
    resources :users
    # end
    # Post admin
    resources :posts
    # end

    devise_scope :user do
      get 'login', to: 'users/sessions#new'
      get 'signup', to: 'users/registrations#new'
      get 'user/password', to: 'users/registrations#edit', as: 'password'
    end
    get 'user/profile', to: 'users#edit', as: 'profile'
    resources :users, only: %w[update show]
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
    get 'tags/show'
  end
end
