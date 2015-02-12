web: bundle exec unicorn -c ./config/unicorn.rb -E $RAILS_ENV -D
worker: bundle exec sidekiq -e $RAILS_ENV
custom_web: bundle exec unicorn -c ./config/unicorn.rb -E $RAILS_ENV -D
