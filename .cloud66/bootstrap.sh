source /var/.cloud66_env

cd $STACK_PATH

bundle exec rake db:migrate
bundle exec rake db:seed

bundle exec rake environment tire:import CLASS='Media' FORCE=true
bundle exec rake environment tire:import CLASS='Post' FORCE=true

bundle exec rake bower:install

# Correct permissions for assets
sudo chmod 0777 -R $RAILS_STACK_PATH/public/*