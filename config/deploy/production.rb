server "54.199.70.11", user: "tomo", roles: %w{app db web}

set :ssh_options, {
  forward_agent: true,
  auth_methods: %w(publickey),
  keys: [File.expand_path('~/.ssh/id_rsa.pem)')]
  port: 22
}
