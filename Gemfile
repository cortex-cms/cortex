source 'https://rubygems.org'
ruby '2.3.0'

# Dependency Management
gem 'bower-rails', '~> 0.10.0'

# Server
gem 'unicorn-rails', '~> 2.2.0'

# Rails
gem 'rails', '~> 4.2.5'

# Cortex-specific
gem 'cortex-exceptions', '~> 0.0.4'

# API
gem 'grape', '~> 0.14'
gem 'grape-entity', '~> 0.4.8'
gem 'grape-swagger', '~> 0.10.4'
gem 'doorkeeper', '~> 1.4'
gem 'redis-rails', '~> 4.0'

# Authorization
gem 'six', '~> 0.2.0'
gem 'devise', '~> 3.5.6'
gem 'rack-oauth2', '~> 1.2.1'

# ActiveRecord
gem 'rails-observers', '~> 0.1.2'
gem 'awesome_nested_set', '~> 3.0'
gem 'paperclip', git: 'git://github.com/thoughtbot/paperclip', branch: 'master'
gem 'paperclip-optimizer', '~> 2.0'
gem 'acts-as-taggable-on', '~> 3.5'
gem 'bcrypt', '~> 3.1.10'
gem 'elasticsearch-model', '~> 0.1'
gem 'elasticsearch-rails', '~> 0.1'
gem 'grape-kaminari', '~> 0.1.8'
gem 'paranoia', '~> 2.1'
gem 'pg', '~> 0.18.4'
gem 'hashie-forbidden_attributes', '~> 0.1.1'
gem 'jsonb_accessor', '~> 0.3.1'

# Middleware
gem 'rack-cors', '~> 0.4.0', require: 'rack/cors'

# Utility
gem 'excon', '~> 0.45.4'
gem 'hashie', '~> 3.4.3'
gem 'hashr', '~> 2.0.0'
gem 'mime-types', '~> 2.99'
gem 'json'
gem 'rubyzip', '~> 1.1.7'
gem 'interactor-rails', '~> 2.0'

# Jobs
gem 'sidekiq', '~> 4.1.0'
gem 'sidekiq-failures', '~> 0.4.5'
gem 'sinatra', '~> 1.4.6', require: false

# Pipeline
gem 'sprockets-rails', '2.3.3', :require => 'sprockets/railtie'
gem 'sprockets', '2.12.4'

# Templating
gem 'haml', '~> 4.0.7'

# Style
gem 'sass-rails', '~> 5.0'
gem 'font-awesome-sass', '~> 4.5.0'

# JS
gem 'ng-rails-csrf', '~> 0.1.0'
gem 'angular-rails-templates', '~> 0.2.0'
gem 'gon', '~> 6.0.1'
gem 'ngmin-rails', '~> 0.4.0'
gem 'uglifier', '~> 2.7.2'

group :test, :development do
  # Environment
  gem 'dotenv', '~> 2.1.0'
  gem 'byebug'

  # Rspec
  gem 'rspec', '~> 3.4'
  gem 'rspec-rails', '~> 3.4'
  gem 'json_spec', '~> 1.1.4'

  # Guard
  gem 'guard-rspec', '~> 4.6.4'

  # Mocking/Faking
  gem 'mocha', '~> 1.1.0', require: false
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'database_cleaner', '~> 1.5.1'

  # Javascript
  gem 'jasmine-rails', '~> 0.12.2'
  gem 'guard-jasmine', '~> 2.0.6'
  gem 'jasmine-core', '~> 2.4'

  # Cache/Sidekiq
  gem 'redis-namespace', '~> 1.5'
end

group :development do
  # Pretty
  gem 'better_errors', '~> 2.1.1'
  gem 'binding_of_caller', '~> 0.7.2' # Used by Better Errors
  gem 'pry-rails', '~> 0.3'
end

group :test do
  gem 'codeclimate-test-reporter', '~> 0.4.8', require: false
  gem 'timecop', '~> 0.8.0'
  gem 'rspec-sidekiq', '~> 2.2.0'
  gem 'elasticsearch-extensions', '~> 0.0.20'
  gem 'email_spec'
end

group :assets do
  gem 'coffee-rails', '~> 4.1.0'
end

group :test, :development, :staging do
  gem 'fog', '~> 1.37.0'
end

group :production do
  gem 'aws-sdk', '~> 2.2' # Used by Paperclip
end

group :staging, :production do
  # Monitoring
  gem 'newrelic_rpm', '~> 3.14.1'
end
