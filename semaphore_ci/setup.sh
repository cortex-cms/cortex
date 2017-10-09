echo "gem update --system"
gem update --system

echo "gem update bundler"
gem update bundler

echo "yarn install"
yarn install

echo "bundle config build.nokogiri --use-system-libraries"
bundle config build.nokogiri --use-system-libraries

echo "bundle install --without production staging development tasks"
bundle install --without production staging development tasks

echo "bundle exec rake cortex:assets:webpack:ensure_all_assets_compiled"
bundle exec rake cortex:assets:webpack:ensure_all_assets_compiled

echo "bundle exec rake db:setup"
bundle exec rake db:setup

echo "bundle exec rake cortex:core:db:reseed"
bundle exec rake cortex:core:db:reseed

echo "bundle exec rake cortex:rebuild_indexes"
bundle exec rake cortex:rebuild_indexes

echo "change-phantomjs-version 2.1.1"
change-phantomjs-version 2.1.1
