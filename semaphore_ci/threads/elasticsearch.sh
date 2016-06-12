echo "ES Install"
sudo service elasticsearch stop
if ! [ -e .semaphore-cache/elasticsearch-2.3.1.deb ]; then (cd .semaphore-cache; curl -OL https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-2.3.1.deb); fi
sudo dpkg -i --force-confnew .semaphore-cache/elasticsearch-2.3.1.deb

sudo /usr/share/elasticsearch/bin/plugin install elasticsearch/elasticsearch-mapper-attachments/3.1.1
echo "script.engine.groovy.inline.aggs: on" | sudo tee --append /etc/elasticsearch/elasticsearch.yml

sudo service elasticsearch start

echo "sleep 10"
sleep 10

echo "ES Version Check"
curl -XGET 'http://localhost:9200'

echo "bundle exec rake cortex:rebuild_indexes"
bundle exec rake cortex:rebuild_indexes
