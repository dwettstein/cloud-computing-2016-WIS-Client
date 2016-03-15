# set your params

identity_file = ''
host = ''
user = 'ubuntu'
port = 22

raise 'You have to fill identity_file and host variables' if identity_file.empty? || host.empty?

# do not modify below

require 'net/ssh/proxy/command'

set :stage, :production

role :app, [host]
role :web, [host]

server host,
  roles: %w{web app},
  port: port,
  ssh_options: {
    user: user, # overrides user setting above
    keys: identity_file,
    forward_agent: true,
    auth_methods: %w(publickey password),
    proxy: Net::SSH::Proxy::Command.new("ssh -i #{identity_file} trampoline@clusterinfo.unineuchatel.ch -W \"%h:%p\"")
  }
