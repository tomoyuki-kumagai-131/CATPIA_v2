# capistranoのバージョンを記載。Gemfile.lock記載のバージョン：バージョン変更によるトラブル防止
lock '3.14.1'

# Capistranoのログの表示に利用する
set :application, 'CATPIA_v2' #自身のアプリ名
set :deploy_to, '/var/www/rails/CATPIA_v2' #EC2上の自身のアプリまでのパス。デプロイ先

# どのリポジトリからアプリをpullするかを指定する
set :repo_url,  'git@github.com:tomo-0131/CATPIA_v2.git' #自分のgithubのレポジトリ

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.5.3' #ローカルから[ruby -v]で調べる

# どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['publickey'],
                  keys: '~/.ssh/catpia_v4.pem' # EC2で作成した[~.pem]のパス

# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
