# config valid only for current version of Capistrano
lock '3.7.0'

set :application, 'inventory'
set :repo_url, 'git@github.com:kreeti/inventory.git'

set :user, "inventory"
set :deploy_to, "/var/deploy/inventory"
set :log_level, :info

set :linked_files, %w{config/database.yml config/secrets.yml config/puma.rb}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets tmp/puma public/system}

namespace :deploy do
  after :publishing, :restart do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      execute :sudo, :systemctl, "restart payroll"
    end
  end
end
