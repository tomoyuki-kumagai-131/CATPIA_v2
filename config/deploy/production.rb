# EC2サーバーのIP、EC2サーバーにログインするユーザー名、サーバーのロールを記述
server '54.199.70.11', user: 'tomo', roles: %w{app db web}

#デプロイするサーバーにsshログインする鍵の情報を記述
set :ssh_options, keys: '~/.ssh/catpia_v4.pem' 

server '54.199.70.11',
   user: 'tomo',
   roles: %w{web db app},
   ssh_options: {
       port: 22,
       keys: %w(~/.ssh/catpia_v4.pem),
       forward_agent: true