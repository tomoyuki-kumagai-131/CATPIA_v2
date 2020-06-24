require "capistrano/setup"
require "capistrano/deploy"
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano3/unicorn'
# Capistranoのタスクを記述したファイルを読み込む設定。場所と拡張子を指定する。
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
