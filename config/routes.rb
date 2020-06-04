# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  get '/tagfeed', to: 'home#tagfeed'
  get '/timeline', to: 'home#timeline'
  get '/milestones', to: 'home#milestones'
  get '/posts-weekly', to: 'home#posts_weekly'
  get '/posts-monthly', to: 'home#posts_monthly'
  get '/confirm', to: 'home#confirm_pages'

  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: %w[update show edit]
  devise_for :admins
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
  end
  get 'confirm', to: 'home#confirm_pages'
end
