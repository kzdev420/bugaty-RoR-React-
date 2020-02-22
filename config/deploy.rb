# config valid only for current version of Capistrano
# To execute this file 'cap production deploy'

## STEP TO DEPLOY ##
## 1. Ask for the password for the AWS server app@52.50.71.53
## 2. Configure SSH access on bitbucket account, See: https://confluence.atlassian.com/bitbucket/set-up-an-ssh-key-728138079.html
## 2.1 make sure your ssh-agent is active by following the 2nd step
## 3 Run cap production deploy

lock '3.6.1'

set :application, 'glob'

set :repo_url, 'git@bitbucket.org:Globsucceed/glob.git'

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/application.yml')
set :linked_dirs, fetch(:linked_dirs, []).push(
                                                'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets',
                                                'vendor/bundle', 'public/system', 'public/uploads',
                                                "public/packs", "node_modules"
                                                )


set :rvm_ruby_version, '2.3.1'

before "deploy:assets:precompile", "deploy:yarn_install"
namespace :deploy do
  desc "Run rake yarn install"
  task :yarn_install do
    on roles(:web) do
      within release_path do
        execute("cd #{release_path} && yarn install --silent --no-progress --no-audit --no-optional")
      end
    end
  end
end

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      #execute :touch, release_path.join('tmp/restart.txt')
      invoke 'unicorn:restart'
    end
  end
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      #execute :touch, release_path.join('tmp/restart.txt')
      invoke 'unicorn:stop'
    end
  end
  after :publishing, :restart
end

namespace :logs do
  desc "tail rails logs"
  task :tail_rails do
    on roles(:app) do
      execute "tail -f #{shared_path}/log/unicorn.stdout.log"
    end
  end
end
