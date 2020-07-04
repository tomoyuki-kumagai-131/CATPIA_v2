server "54.199.70.11",
  user: "tomo",
  roles: %w{app db web},
  port: 22,
  ssh_options, {
    user: "tomo",
    keys: %w(~/.ssh/catpia_v4.pem),
    #auth_methods: %w(publickey),
    forward_agent: true
  }
