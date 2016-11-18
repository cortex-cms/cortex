ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'

require 'api_v1_helper'

require 'mocha/api'
require 'elasticsearch/extensions/test/cluster'
require 'net/http'
require 'email_spec'
require 'capybara/rspec'
require 'capybara/rails'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {js_errors: false})
end

include ActionDispatch::TestProcess

Dir[Rails.root.join("spec/support/**/*_support.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  elasticsearch_status = false

  config.include Warden::Test::Helpers
  config.include FactoryGirl::Syntax::Methods

  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers

  config.include Devise::TestHelpers, :type => :controller

  config.include RSpec::Rails::RequestExampleGroup, type: :request, file_path: /spec\/api/

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    Capybara.current_driver = Capybara.javascript_driver
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

  config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'

  config.before :each, elasticsearch: true do
    Elasticsearch::Extensions::Test::Cluster.start(port: 9200) unless Elasticsearch::Extensions::Test::Cluster.running?(on: 9200) || elasticsearch_status
  end

  config.after :suite do
    Elasticsearch::Extensions::Test::Cluster.stop(port: 9200) if Elasticsearch::Extensions::Test::Cluster.running? on: 9200
  end

  RSpec::Sidekiq.configure do |config|
    config.warn_when_jobs_not_processed_by_sidekiq = false
  end
end
