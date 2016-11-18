require 'simplecov'
SimpleCov.start 'rails' do
  add_filter do |source_file|
    source_file.filename.include?("_spec.rb")
  end
end

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'rails_helper'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
    mocks.allow_message_expectations_on_nil = true
  end
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
