# EC2サーバーのIP、EC2サーバーにログインするユーザー名、サーバーのロールを記述
server '54.199.70.11',
    user: 'ec2-user',
    roles: %w{web db app},
set :ssh_options: {
        port: 22,
        keys: '~/.ssh/catpia_v4.pem',
        }
