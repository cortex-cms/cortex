# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'rspec/rails'
require 'shoulda'
require 'mocha/api'
require 'elasticsearch/extensions/test/cluster'
require 'net/http'

include ActionDispatch::TestProcess
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|

  elasticsearch_status = false

  config.mock_with :mocha
  config.include Warden::Test::Helpers
  config.include FactoryGirl::Syntax::Methods
  config.include Helpers

  config.include Devise::TestHelpers, :type => :controller

  config.include RSpec::Rails::RequestExampleGroup, type: :request, file_path: /spec\/api/

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    elasticsearch_status = test_elasticsearch
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    Warden.test_reset!
  end

  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'

  # awesome_nested_set has an _extremely_ noisy depreciation warning issue
  # https://github.com/collectiveidea/awesome_nested_set/issues/220
  ActiveSupport::Deprecation.silenced = true

  config.before :each, elasticsearch: true do
    Elasticsearch::Extensions::Test::Cluster.start(port: 9200) unless Elasticsearch::Extensions::Test::Cluster.running?(on: 9200) || elasticsearch_status
  end

  config.after :suite do
    Elasticsearch::Extensions::Test::Cluster.stop(port: 9200) if Elasticsearch::Extensions::Test::Cluster.running? on: 9200
  end
end

RSpec::Sidekiq.configure do |config|
  config.warn_when_jobs_not_processed_by_sidekiq = false
end

def test_elasticsearch
  url = URI('http://localhost:9200/')
  begin
    res = Net::HTTP.get_response(url)
    res.is_a?(Net::HTTPSuccess)
  rescue
    false
  end
end
