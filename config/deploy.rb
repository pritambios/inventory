# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'inventory'
set :repo_url, 'git@github.com:kreeti/inventory.git'

set :user, "inventory"
set :deploy_to, "/var/deploy/inventory"
set :log_level, :info

set :linked_files, %w{config/database.yml config/secrets.yml config/puma.rb}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets tmp/puma public/system}
