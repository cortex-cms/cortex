source 'https://rubygems.org'
ruby '2.2.2'

# Dependency Management
gem "bower-rails", "~> 0.10.0"

# Server
gem 'unicorn-rails', '~> 2.2.0'

# Rails
gem 'rails', '~> 4.2'

# Cortex-specific
gem 'cortex-exceptions', '~> 0.0.4'

# API
gem 'grape', '~> 0.11'
gem 'grape-entity', '~> 0.4.5'
gem 'grape-swagger', '~> 0.10.1'
gem 'doorkeeper', '~> 1.4'
gem 'redis-rails', '~> 4.0'

# Authorization
gem 'six', '~> 0.2.0'
gem 'devise', '~> 3.4.1'
gem 'rack-oauth2', '~> 1.1.1'

# ActiveRecord
gem 'rails-observers', '~> 0.1.2'
gem 'awesome_nested_set', '~> 3.0'
gem 'paperclip', git: 'git://github.com/betesh/paperclip', branch: 'master'
gem 'paperclip-optimizer', '~> 2.0'
gem 'acts-as-taggable-on', '~> 3.5'
gem 'bcrypt', '~> 3.1.10'
gem 'elasticsearch-model', '~> 0.1'
gem 'elasticsearch-rails', '~> 0.1'
gem 'kaminari', '~> 0.16.3'
gem 'paranoia', '~> 2.1'
gem 'pg', '~> 0.18.2'
gem 'hashie-forbidden_attributes', '~> 0.1.1'

# Middleware
gem 'rack-cors', '~> 0.4.0', require: 'rack/cors'

# Utility
gem 'excon', '~> 0.45.1'
gem 'hashie', '~> 3.4.1'
gem 'hashr', '~> 0.0.22'
gem 'mime-types', '~> 2.5.0'
gem 'json'
gem 'rubyzip', '~> 1.1.7'

# Jobs
gem 'sidekiq', '~> 3.5.0'
gem 'sidekiq-failures', '~> 0.4.5'
gem 'sinatra', '~> 1.4.6', require: false

# Interactors
gem 'interactor-rails', '~> 2.0'

# Pipeline
gem 'sprockets-rails', '~> 2.3', :require => 'sprockets/railtie'
gem 'sprockets', '~> 2.12.3'

# Templating
gem 'haml', '~> 4.0.6'

# Style
gem 'sass-rails', '~> 5.0'

# JS
gem 'ng-rails-csrf', '~> 0.1.0'
gem 'angular-rails-templates', '~> 0.2.0'
gem 'gon', '~> 5.2.3'
gem 'ngmin-rails', '~> 0.4.0'
gem 'uglifier', '~> 2.7.1'

group :test, :development do
  # Environment
  gem 'dotenv', '~> 2.0.1'
  gem 'byebug'

  # Rspec
  gem 'rspec', '~> 3.2'
  gem 'rspec-rails', '~> 3.2'
  gem 'json_spec', '~> 1.1.4'

  # Guard
  gem 'guard-rspec', '~> 4.6.4'

  # Mocking/Faking
  gem 'mocha', '~> 1.1.0', require: false
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'database_cleaner', '~> 1.4.1'

  # Javascript
  gem 'jasmine-rails', '~> 0.10.7'
  gem 'guard-jasmine', '~> 2.0.6'
  gem 'jasmine-core', '~> 2.3'
end

group :development do
  # Pretty
  gem 'better_errors', '~> 2.1.1'
  gem 'binding_of_caller', '~> 0.7.2' # Used by Better Errors
  gem 'pry-rails', '~> 0.3'
end

group :test do
  gem 'codeclimate-test-reporter', '~> 0.4.7', require: false
  gem 'timecop', '~> 0.7.3'
  gem 'rspec-sidekiq', '~> 2.0.0'
  gem 'elasticsearch-extensions', '~> 0.0.18'
  gem 'email_spec'
end

group :assets do
  gem 'coffee-rails', '~> 4.1.0'
end

group :test, :development, :staging do
  gem 'fog', '~> 1.32.0'
end

group :production do
  gem 'aws-sdk', '~> 2.1' # Used by Paperclip
end

group :staging, :production do
  # Monitoring
  gem 'newrelic_rpm', '~> 3.12.1'
end
