server "54.199.70.11", user: "tomo", roles: %w{app db web}

set :ssh_options, {
  keys: %w(~/.ssh/catpia_v4.pem),
  forward_agent: true,
  auth_methods: %w(publickey)
  port: 22
}
