echo "gem update --system"
gem update --system

echo "gem update bundler"
gem update bundler

echo "bundle config build.nokogiri --use-system-libraries"
bundle config build.nokogiri --use-system-libraries

echo "bundle install --without production staging development tasks"
bundle install --without production staging development tasks

echo "bundle exec rake db:setup"
bundle exec rake db:setup

echo "bundle exec rake db:schema:load db:seed cortex:create_categories"
bundle exec rake db:schema:load db:seed cortex:create_categories

echo "bundle exec rake bower:install:development"
bundle exec rake bower:install:development
