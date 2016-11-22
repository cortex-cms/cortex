echo "gem update --system"
gem update --system

echo "gem update bundler"
gem update bundler

echo "bundle config build.nokogiri --use-system-libraries"
bundle config build.nokogiri --use-system-libraries

echo "bundle install --without production staging development tasks"
bundle install --without production staging development tasks

echo "bundle exec rake bower:install:development"
bundle exec rake bower:install:development

echo "ES Install"
sudo service elasticsearch stop
if ! [ -e .semaphore-cache/elasticsearch-2.4.1.deb ]; then (cd .semaphore-cache; curl -OL https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-2.4.1.deb); fi
sudo dpkg -i --force-confnew .semaphore-cache/elasticsearch-2.4.1.deb
sudo service elasticsearch start

echo "sleep 5"
sleep 5

echo "ES Version Check"
curl -XGET 'http://localhost:9200'

echo "bundle exec rake db:setup"
bundle exec rake db:setup

echo "bundle exec rake cortex:create_categories cortex:onet:fetch_and_provision cortex:core:db:reseed"
bundle exec rake cortex:create_categories cortex:onet:fetch_and_provision cortex:core:db:reseed

echo "bundle exec rake cortex:rebuild_indexes"
bundle exec rake cortex:rebuild_indexes
