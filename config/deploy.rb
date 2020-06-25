# config valid only for current version of Capistrano
lock '3.7.0'

set :application, 'CATPIA_v2'
set :repo_url, 'git@github.com:tomo-0131/CATPIA_v2.git'

# Default branch is :master
set :branch, ENV['BRANCH'] || 'master'

# deployするときのUser名（サーバ上にこの名前のuserが存在しAccessできることが必要）
set :user, 'tomo'

set :puma_threds,  [4, 16]
set :puma_workers, 0
set :pty, true
set :rbenv_ruby, '2.5.3'

# 必要に応じて、gitignoreしているファイルにLinkを貼る
set :linked_files, %w{.rbenv-vars}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :use_sudo, false
set :stage, :production
set :deploy_via, :remote_cache

# deploy先サーバにおく場所
set :deploy_to, "/var/www/rails/#{fetch(:application)}"

# bundle
set :bundle_path, -> { shared_path.join('vendor/bundle') }

# Set Gemfile
# set :bundle_gemfile,  "/var/www/myapp/current/Gemfile"

set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/catpia_v4.pem), port: 22 }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

set :keep_releases, 2


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
  desc "Make sure local git is in sync with remote."
  task :confirm do
    on roles(:app) do
      puts "This stage is '#{fetch(:stage)}'. Deploying branch is '#{fetch(:branch)}'."
      puts 'Are you sure? [y/n]'
      ask :answer, 'n'
      if fetch(:answer) != 'y'
        puts 'deploy stopped'
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  before :starting,     :confirm
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup

end