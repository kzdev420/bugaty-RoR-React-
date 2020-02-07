require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/ssh_doctor'
require 'capistrano/deploy'
require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails'
require 'capistrano3/unicorn'
require 'capistrano/faster_assets'
require 'capistrano-db-tasks'
require 'capistrano/yarn'
require 'capistrano/sitemap_generator'
require 'whenever/capistrano'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }

after 'deploy', 'sitemap:refresh'
