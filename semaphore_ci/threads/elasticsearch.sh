sleep 10
bundle exec rake cortex:rebuild_indexes
bundle exec rspec spec/controllers
bundle exec rspec spec/api
