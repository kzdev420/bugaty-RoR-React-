# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server 'example.com', user: 'deploy', roles: %w{app db web}, my_property: :my_value
# server 'example.com', user: 'deploy', roles: %w{app web}, other_property: :other_value

server '52.50.71.53', user: 'app', roles: %w{web app db}, primary: true

# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any  hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

role :web,  %w{app@52.50.71.53}
role :app,  %w{app@52.50.71.53}
role :db,  %w{app@52.50.71.53}

set :rails_env, :production
set :stage, :production


# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.

set :deploy_to, "/home/app/production"
set :deploy_user, 'app'

set :keep_releases, 5

set :branch, 'master'

# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
# set :ssh_options, {
#   keys: %w(/Users/boris/.ssh/id_rsa),
#   forward_agent: true,
#   auth_methods: %w(publickey password),
#   port: 22
# }
