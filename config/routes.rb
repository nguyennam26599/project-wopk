# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  devise_for :admins
  devise_scope :user do
    get 'login', to: 'users/sessions#new'
    get 'signup', to: 'users/registrations#new'
  end
  namespace :admins do
    root 'pages#index'
    get 'form' => 'pages#form'
    get 'table' => 'pages#table'
  end
  root 'home#index'
  get 'confirm', to: 'home#confirm_pages'
end
