# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'rspec/rails'
require 'shoulda'
require 'mocha/api'

include ActionDispatch::TestProcess
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|

  config.mock_with :mocha
  config.include Warden::Test::Helpers
  config.include FactoryGirl::Syntax::Methods
  config.include Helpers

  config.include Devise::TestHelpers, :type => :controller

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    FactoryGirl.lint
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
end
