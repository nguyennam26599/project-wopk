# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get 'login', to: 'users/sessions#new'
    get 'signup', to: 'users/registrations#new'
  end
  get 'test/index'
  namespace :admin do
    root 'pages#index'
    get 'form' => 'pages#form'
    get 'table' => 'pages#table'
  end
  root 'home#index'
end
