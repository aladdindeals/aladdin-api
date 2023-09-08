# config valid for current version and patch releases of Capistrano
lock "~> 3.17.3"

set :stages, %w(staging production)
set :default_stage, "production"
set :application, "aladdin-api"
set :repo_url, "git@github.com:aladdindeals/aladdin-api.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"
set :deploy_to, '/root/api/'
set :log_level, :debug
set :rbenv_type, :user
set :rbenv_ruby, '3.1.4'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/master.key config/secrets.yml config/redis.yml }

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", " vendor/bundle", ".bundle", "public/system", "public/uploads", "node_modules"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 3
set :connection_timeout, 5
# Skip migration if files in db/migrate were not modified
# Defaults to false
set :conditionally_migrate, true

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
before 'deploy:starting', 'config_files:upload'
set :initial, true
after 'deploy:publishing', 'application:reload'
after 'deploy:starting', 'sidekiq:quiet'
after 'deploy:reverted', 'sidekiq:restart'
after 'deploy:published', 'sidekiq:restart'
