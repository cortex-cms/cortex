# Ensure elasticsearch-model is hooked up with pagination
Kaminari::Hooks.init
Elasticsearch::Model::Response::Response.__send__ :include, Elasticsearch::Model::Response::Pagination::Kaminari

Elasticsearch::Model.client = Elasticsearch::Client.new url: ENV['ELASTICSEARCH_ADDRESS']
