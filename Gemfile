source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Declare your gem's dependencies in cortex.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]

group :development, :test do
  # Environment
  gem 'dotenv-rails', require: 'dotenv/rails-now'

  # Debug
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-rails'
  gem 'pry-nav'
  gem 'pry-remote'
  gem 'pry-stack_explorer'

  # Specs/Helpers
  gem 'rspec-rails'
  gem 'guard-rspec', require: false
  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 4.8' # TODO: upgrade to factory_bot
  gem 'faker', '~> 1.8'
  gem 'phantomjs', '~> 2.1'
  gem 'jasmine-rails', '~> 0.14'

  # Documentation
  gem 'rails-erd'

  #
  # Dummy Spec App
  #

  # Pipeline
  gem 'sprockets-rails', '3.2.1', require: 'sprockets/railtie'
  gem 'sprockets', '3.7.2'
  gem 'uglifier', '~> 3.2.0'

  # View
  gem 'haml', '~> 5.0'

  # Style
  gem 'sass-rails', '~> 5.0'

  # Cortex
  gem 'cortex-plugins-core', '~> 3.0'

  # Jobs
  gem 'sidekiq', '~> 5.1.3'
  gem 'sidekiq-failures', '~> 1.0.0'
  gem 'sinatra', '~> 2.0.3'

  # Data
  gem 'pg', '>= 0.18', '< 2.0'
  gem 'redis-rails', '~> 5.0'

  # API
  gem 'apollo-tracing', '~> 1.6.0'

  # JavaScript
  gem 'react_on_rails', '9.0.3'
  gem 'mini_racer'
  gem 'webpacker'
end

group :test do
  # Rspec
  gem 'json_spec', '~> 1.1'
  gem 'rspec-sidekiq', '~> 3.0'
  gem 'shoulda-matchers', '~> 3.1'
  gem "rspec_junit_formatter"

  # Coverage
  gem 'simplecov'
  gem 'codeclimate-test-reporter'

  # Capybara for feature testing, Poltergeist for PhantomJS
  gem 'capybara'
  gem 'poltergeist'

  # Mocking/Faking
  gem 'mocha', '~> 1.3', require: false
  gem 'timecop', '~> 0.9'
  gem 'email_spec'

  # Javascript
  gem 'guard-jasmine', '~> 2.1'
  gem 'jasmine-core', '~> 2.8'

  # Data
  gem 'elasticsearch-extensions', '~> 0.0.29'
end
