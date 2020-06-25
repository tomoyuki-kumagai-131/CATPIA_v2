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
