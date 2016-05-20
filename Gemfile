source 'https://rubygems.org'
ruby '2.3.0'

# Dependency Management
gem 'bower-rails', '~> 0.10.0'

# Server
gem 'unicorn-rails', '~> 2.2.0'

# Rails
gem 'rails', '~> 4.2.6'

# Cortex-specific
gem 'cortex-exceptions', '~> 0.0.4'

# API
gem 'grape', '~> 0.16'
gem 'grape-entity', '~> 0.5.1'
gem 'grape-swagger', '~> 0.20.3'

# Authorization
gem 'six', '~> 0.2.0'
gem 'devise', '~> 3.5.6'
gem 'rack-oauth2', '~> 1.3.0'
gem 'doorkeeper', '~> 3.1'

# Data
gem 'rails-observers', '~> 0.1.2'
gem 'awesome_nested_set', '~> 3.0'
gem 'paperclip', '~> 5.0.0.beta2'
gem 'paperclip-optimizer', '~> 2.0'
gem 'acts-as-taggable-on', '~> 3.5'
gem 'bcrypt', '~> 3.1.11'
gem 'grape-kaminari', git: 'git://github.com/toastercup/grape-kaminari', branch: 'set-only-pagination-headers'
gem 'elasticsearch-model', '~> 0.1'
gem 'elasticsearch-rails', '~> 0.1'
gem 'paranoia', '~> 2.1'
gem 'pg', '~> 0.18.4'
gem 'hashie-forbidden_attributes', '~> 0.1.1'
gem 'redis-rails', '~> 4.0'

# Middleware
gem 'rack-cors', '~> 0.4.0', require: 'rack/cors'

# Utility
gem 'excon', '~> 0.48.0'
gem 'hashie', '~> 3.4.3'
gem 'hashr', '~> 2.0.0'
gem 'mime-types', '~> 2.99.1'
gem 'interactor-rails', '~> 2.0'
gem 'rubyzip', '~> 1.2.0'
gem 'addressable', '~> 2.4.0'
gem 'json'

# External Services
gem 'yt', '~> 0.25.5'
gem 'aws-sdk', '~> 2.2' # Used by Paperclip

# Jobs
gem 'sidekiq', '~> 4.1.1'
gem 'sidekiq-failures', '~> 0.4.5'
gem 'sinatra', '~> 1.4.7', require: false

# Pipeline
gem 'sprockets-rails', '3.0.4', :require => 'sprockets/railtie'
gem 'sprockets', '3.5.2'
gem 'angular-rails-templates', '~> 1.0.0'
gem 'ngannotate-rails', git: 'git://github.com/kikonen/ngannotate-rails', branch: 'master' # sprockets-rails related fixes not present in v0.15.4.1
gem 'uglifier', '~> 2.7.2'

# Templating
gem 'haml', '~> 4.0.7'

# Style
gem 'sass-rails', '~> 5.0'
gem 'font-awesome-sass', '~> 4.5.0'

# JS
gem 'ng-rails-csrf', '~> 0.1.0'
gem 'gon', '~> 6.0.1'

group :tasks do
  # Parsing
  gem 'nokogiri'
end

group :test, :development do
  # Environment
  gem 'dotenv', '~> 2.1.0'
  gem 'byebug'
  gem 'spring'

  # Cache/Sidekiq
  gem 'redis-namespace', '~> 1.5'

  # Pretty
  gem 'better_errors', '~> 2.1.1'
  gem 'binding_of_caller', '~> 0.7.2' # Used by Better Errors
  gem 'pry-rails', '~> 0.3'
end

group :test do
  # Rspec
  gem 'rspec', '~> 3.4'
  gem 'rspec-rails', '~> 3.4'
  gem 'json_spec', '~> 1.1.4'
  gem 'rspec-sidekiq', '~> 2.2.0'

  # Capybara for feature testing, Poltergeist for PhantomJS
  gem 'capybara'
  gem 'poltergeist'

  # Guard
  gem 'guard-rspec', '~> 4.6.4'

  # Mocking/Faking
  gem 'mocha', '~> 1.1.0', require: false
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'database_cleaner', '~> 1.5.1'
  gem 'timecop', '~> 0.8.0'
  gem 'email_spec'

  # Javascript
  gem 'guard-jasmine', '~> 2.0.6'
  gem 'jasmine-core', '~> 2.4'

  # Etc
  gem 'codeclimate-test-reporter', '~> 0.4.8', require: false
  gem 'elasticsearch-extensions', '~> 0.0.20'
end

group :test, :development do
  gem 'fog', '~> 1.37.0'
  gem 'jasmine-rails', '~> 0.12.2'
end

group :staging, :production do
  # Monitoring
  gem 'newrelic_rpm', '~> 3.15.0'
end
