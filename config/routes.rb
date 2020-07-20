# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  get '/tagfeed', to: 'home#tagfeed'
  get '/clippost', to: 'home#clippost'
  get '/confirm', to: 'home#confirm_pages'

  devise_for :users, controllers: { registrations: 'registrations', confirmations: 'users/confirmations' }
  devise_for :admins
  resources :follow_polymorphics
  # routes create post function
  resources :posts do
    member do
      post :view
      put :clip, to: 'follow_polymorphics#clip'
      put 'vote', to: 'post_votings#vote'
      resources :comments
    end
  end

  resources :tags do
    collection do
      get :search
      post :follow_tag
    end
  end
  # end

  devise_scope :user do
    get 'login', to: 'users/sessions#new'
    get 'signup', to: 'users/registrations#new'
    get 'user/password', to: 'users/registrations#edit', as: 'password'
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
    resources :comments
    resources :reports do
      collection do
        put 'report_post'
        put 'noreport_post'
      end
    end
    get 'reports/posts(/:id)', to: 'reports#show_post'
  end
  get 'tags/show'
end
