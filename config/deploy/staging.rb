# frozen_string_literal: true

server 'qiita_intern_ruby', roles: %w[web app db batch], primary: true
set :rails_env, 'staging'
set :branch, 'develop'
set :user, 'admin'
set :rack_env, 'staging'
set :puma_env, 'staging'
