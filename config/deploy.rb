# config valid for current version and patch releases of Capistrano
lock '~> 3.17.2'

set :application, 'cortex'
set :repo_url, 'https://github.com/cortex-cms/cortex.git'
set :deploy_to, "/var/www/#{fetch :application}"
set :s3_path_stage, 's3://cortex-env/Stage/.env'
set :s3_path_prod, ''
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
set :ssh_options, verify_host_key: :secure

namespace :remote do
  desc "Download env from S3"
  task :env_download do
    on roles(:all) do |host|
      execute "aws s3 cp #{fetch :s3_path_stage} #{fetch :deploy_to}/current/.env"
    end
  end

  desc 'Terminate existing puma and sidekiq processes'
  task :terminate_puma_sidekiq do
    on roles(:all) do |host|
      execute 'sudo killall puma'
      execute 'sudo killall sidekiq'
    end
  end
end
