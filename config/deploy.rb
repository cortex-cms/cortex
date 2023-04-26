# config valid for current version and patch releases of Capistrano
lock '~> 3.17.2'

set :application, 'cortex'
set :repo_url, 'https://github.com/cortex-cms/cortex.git'
set :deploy_to, "/var/www/#{fetch :application}"
set :s3_path_stage, 's3://cortex-env/Stage/.env'
set :s3_path_prod, ''

# RVM options
set :rvm1_ruby_version, "2.4.5"
set :rvm_type, :user
set :default_env, { rvm_bin_path: '~/.rvm/bin' }

# NPM options
set :npm_flags, '--silent --no-progress'    # default
set :npm_roles, :all                                     # default
set :npm_env_variables, {}                               # default
set :npm_method, 'ci'                               # default

before 'deploy', 'rvm1:install:rvm'
before 'deploy', 'rvm1:install:ruby'
after 'npm:install', 'remote:application_setup'
# after 'deploy:symlink:release', 'remote:server_startup'
after 'deploy:publishing', 'thin:restart'
# after 'deploy', 'remote:terminate_puma_sidekiq'
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
# append :linked_files, 'start.sh'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/assets', 'vendor', 'bower_components'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
set :ssh_options, verify_host_key: :secure

namespace :remote do
  desc 'Download env from S3'
  task :env_download do
    on roles(:all) do |host|
      execute "aws s3 cp #{fetch :s3_path_stage} #{fetch :release_path}/.env"
    end
  end

  desc 'Application setup'
  task :application_setup do
    on roles(:all) do |host|
      within release_path do
        execute :gem, "update --system 3.2.3"
        execute :bundle, 'install'
        execute :npm, 'install'
        execute "source #{fetch :release_path}/.env"
        execute :bundle, 'exec rake assets:clean'
        execute :bundle, 'exec rake react_on_rails:assets:clobber'
        execute "cd #{fetch :release_path}; #{fetch :release_path}/node_modules/.bin/bower install angular-mocks#1.2"
        execute :bundle, 'exec rake cortex:assets:webpack:compile'
        execute :bundle, 'exec rake assets:precompile'
      end
      execute "cd #{fetch :release_path}"
    end
  end
  before :application_setup, 'rvm1:hook'
  before :application_setup, 'env_download'

#   task :server_startup do
#     on roles(:all) do |host|
#       within current_path do
#         execute "cd #{fetch :release_path}; nohup foreman start -f Procfile &"
#         execute "cd #{fetch :release_path}; nohup bundle exec sidekiq -e staging --config ./config/sidekiq.yml &"
#       end
#     end
#   end
#   before :server_startup, 'rvm1:hook'
#   before :server_startup, 'terminate_puma_sidekiq'

#   desc 'Terminate existing puma and sidekiq processes'
#   task :terminate_puma_sidekiq do
#     on roles(:all) do |host|
#       execute 'sudo killall puma &'
#       execute 'sudo killall sidekiq &'
#     end
#   end
end
