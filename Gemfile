source 'https://rubygems.org'
source 'https://rails-assets.org'

# Server
gem 'unicorn-rails', '~> 2.2.0'

# Rails
gem 'rails', '~> 4.2'

# Cortex-specific
gem 'cortex-exceptions', '~> 0.0.4'

# Localization
gem 'jargon-client', git: 'git://github.com/cb-talent-development/jargon-client'

# API
gem 'grape', '~> 0.10'
gem 'grape-entity', '~> 0.4.4'
gem 'grape-swagger', '~> 0.9.0'
gem 'doorkeeper', '~> 1.4'
gem 'redis-rails', '~> 4.0'

# Templating
gem 'haml', '~> 4.0.6'

# Style
gem 'sass-rails', '~> 5.0'
gem 'font-awesome-sass', '~> 4.2.2'

gem 'sprockets-rails', '~> 2.2'

# JS
gem 'ng-rails-csrf', '~> 0.1.0'
gem 'angular-rails-templates', '~> 0.1.3'
gem 'gon', '~> 5.2.3'
gem 'jquery-rails', '~> 4.0.3'
gem 'momentjs-rails', '~> 2.9.0'
gem 'ngmin-rails', '~> 0.4.0'
gem 'turbolinks', '~> 2.5.3'
gem 'uglifier', '~> 2.7.0'
gem 'underscore-rails', '~> 1.7.0'

gem 'rails-assets-angular', '~> 1.2'
gem 'rails-assets-angular-animate', '~> 1.2'
gem 'rails-assets-angular-sanitize', '~> 1.3.5'
gem 'rails-assets-angular-resource', '~> 1.2'
gem 'rails-assets-angular-cookies', '~> 1.2'
gem 'rails-assets-angular-ui-router', '~> 0.2'
gem 'rails-assets-angular-bootstrap', '~> 0.12'
gem 'rails-assets-angular-flash', '~> 0.1.14'
gem 'rails-assets-angular-bootstrap-datetimepicker', '~> 0.3.8'
gem 'rails-assets-angular-redactor', '~> 1.1.3'
gem 'rails-assets-angularjs-file-upload', '~> 2.0.2'
gem 'rails-assets-ng-table', '~> 0.3.3'
gem 'rails-assets-bootstrap-sass-official', '~> 3.3.1'
gem 'rails-assets-ng-tags-input', '~> 2.1.1'
gem 'rails-assets-angular-bootstrap-switch', '~> 0.3'
gem 'rails-assets-angular-validation-match', '< 1.4'

# ActiveRecord
gem 'rails-observers', '~> 0.1.2'
gem 'awesome_nested_set', '~> 3.0'
gem 'paperclip', '~> 4.2'
gem 'acts-as-taggable-on', '~> 3.4'
gem 'bcrypt', '~> 3.1.9'
gem 'elasticsearch-model', '~> 0.1'
gem 'elasticsearch-rails', '~> 0.1'
gem 'kaminari', '~> 0.16.1'
gem 'sanitize', '~> 3.1'
gem 'paranoia', '~> 2.0'
gem 'pg', '~> 0.18.1'
gem 'activeuuid', git: 'git@github.com:cb-talent-development/activeuuid.git'

# Authorization
gem 'six', '~> 0.2.0'
gem 'devise', '~> 3.4.1'
gem 'rack-oauth2', '~> 1.0.9'

# Utility
gem 'hashr', '~> 0.0.22'
gem 'mime-types', '~> 2.4.3'
gem 'json'

# Middleware
gem 'rack-cors', '~> 0.3.1', require: 'rack/cors'

# Jobs
gem 'sidekiq', '~> 3.3.0'
gem 'sidekiq-failures', '~> 0.4.3'
gem 'sinatra', '~> 1.4.5', require: false

# Interactors
gem 'interactor-rails', '~> 2.0'

group :test, :development do
  # Environment
  gem 'dotenv', '~> 1.0.2'

  # Rspec
  gem 'rspec', '~> 3.1'
  gem 'rspec-rails', '~> 3.1'
  gem 'json_spec', '~> 1.1.4'

  # Guard
  gem 'guard-rspec', '~> 4.5.0'

  # Mocking/Faking
  gem 'mocha', '~> 1.1.0', require: false
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'database_cleaner', '~> 1.4.0'

  # Javascript
  gem 'jasmine-rails', '~> 0.10.6'
  gem 'guard-jasmine', '~> 2.0.2'
  gem 'jasmine-core', '~> 2.1'
  gem 'rails-assets-angular-mocks', '~> 1.2'
  gem 'rails-assets-sinonjs', '~> 1.10.2'
  gem 'rails-assets-sinon-ng', '~> 0.1.2'
  gem 'rails-assets-angular-debaser', '~> 0.3.2'
end

group :development do
  # Pretty
  gem 'better_errors', '~> 2.1.1'
  gem 'binding_of_caller', '~> 0.7.2' # Used by Better Errors
  gem 'pry-rails', '~> 0.3'
end

group :test do
  gem 'codeclimate-test-reporter', '~> 0.4.5', require: false
  gem 'timecop', '~> 0.7.1'
  gem 'rspec-sidekiq', '~> 2.0.0'
  gem 'elasticsearch-extensions', '~> 0.0.17'
end

group :assets do
  gem 'coffee-rails', '~> 4.1.0'
end

group :production do
  gem 'aws-sdk', '~> 1.61.0' # Used by Paperclip
end

group :staging, :production do
  # Monitoring
  gem 'newrelic_rpm', '~> 3.9.9'
end
