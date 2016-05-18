gem update --system
gem update bundler
bundle config build.nokogiri --use-system-libraries
bundle install --without production staging development tasks
bundle exec rake db:setup
bundle exec rake db:schema:load db:seed cortex:create_categories
bundle exec rake bower:install:development
