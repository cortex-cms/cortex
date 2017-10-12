Elasticsearch::Model.client = Elasticsearch::Client.new url: ENV['ELASTICSEARCH_ADDRESS']
