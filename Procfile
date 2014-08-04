web: bundle exec rails server thin -p $PORT -e $RAILS_ENV
worker: bundle exec sidekiq -e $RAILS_ENV
custom_web: bundle exec unicorn -c ./config/unicorn.rb -p $PORT -E $RAILS_ENV -D
