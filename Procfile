web: bundle exec rails server thin -p $PORT -e $RAILS_ENV
worker: bundle exec sidekiq -e $RAILS_ENV
custom_web: bundle exec unicorn_rails -c config/unicorn.rb -E $RAILS_ENV -D
