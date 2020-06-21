# EC2サーバーのIP、EC2サーバーにログインするユーザー名、サーバーのロールを記述
server '54.199.70.11', user: 'tomo', roles: %w{web db app}

set :ssh_options, keys: '~/.ssh/catpiav4_key_rsa'
