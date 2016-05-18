echo "sleep 10"
sleep 10

echo "bundle exec rake cortex:rebuild_indexes"
bundle exec rake cortex:rebuild_indexes

echo "bundle exec rspec spec/controllers"
bundle exec rspec spec/controllers

echo "bundle exec rspec spec/api"
bundle exec rspec spec/api
