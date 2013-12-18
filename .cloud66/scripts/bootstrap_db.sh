bundle exec rake db:drop
bundle exec rake db:create

bundle exec rake db:migrate
bundle exec rake db:seed

bundle exec rake apartment:create
bundle exec rake apartment:migrate
bundle exec rake apartment:seed
