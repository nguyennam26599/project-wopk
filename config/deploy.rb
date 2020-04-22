# frozen_string_literal: true

# config valid only for current version of Capistrano
lock '3.4.1'

set :application, 'qiita'

set :repo_url, 'git@gitlab.nal.vn:hoangpn/qiita-hituno-intern.git'
set :deploy_to, "/home/admin/#{fetch(:application)}"

set :linked_files, %w[config/database.yml config/application.yml .env]
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets vendor/bundle
                     public/system public/uploads public/pack node_modules]
set :keep_releases, 1
set :pty, true
set :rvm_type, :user
set :rvm_ruby_version, 'ruby-2.6.3'
set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env))
set :puma_threads, [0, 8]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_preload_app, false

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  desc 'Run rake yarn install'
  task :yarn_install do
    on roles(:web) do
      within release_path do
        execute("cd #{release_path} && yarn install --silent --no-progress --no-audit --no-optional")
      end
    end
  end

  before 'deploy:assets:precompile', 'deploy:yarn_install'
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end
