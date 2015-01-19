source 'https://rubygems.org'
source 'https://rails-assets.org'

def darwin_only(require_as)
  RUBY_PLATFORM.include?('darwin') && require_as
end

def linux_only(require_as)
  RUBY_PLATFORM.include?('linux') && require_as
end

# Server
gem 'unicorn-rails'

# Rails
gem 'rails', '~> 4.2'

# Cortex-specific
gem 'cortex-exceptions'

# Localization
gem 'jargon-client', git: 'git://github.com/cb-talent-development/jargon-client'

# API
gem 'grape', '~> 0.10'
gem 'grape-entity'
gem 'grape-swagger'
gem 'doorkeeper', '~> 1.4'
gem 'redis-rails', '~> 4.0'

# Templating
gem 'haml'

# Style
gem 'sass-rails', '~> 5.0'
gem 'font-awesome-sass'

gem 'sprockets-rails', '~> 2.2'

# JS
gem 'ng-rails-csrf'
gem 'angular-rails-templates'
gem 'gon'
gem 'jquery-rails'
gem 'momentjs-rails'
gem 'ngmin-rails'
gem 'therubyracer'
gem 'turbolinks'
gem 'uglifier'
gem 'underscore-rails'

gem 'rails-assets-angular', '~> 1.2'
gem 'rails-assets-angular-animate'
gem 'rails-assets-angular-sanitize'
gem 'rails-assets-angular-resource'
gem 'rails-assets-angular-cookies'

gem 'rails-assets-angular-ui-router', '~> 0.2'
gem 'rails-assets-angular-bootstrap', '~> 0.12'
gem 'rails-assets-angular-flash'
gem 'rails-assets-angular-bootstrap-datetimepicker'
gem 'rails-assets-angular-redactor'
gem 'rails-assets-angularjs-file-upload', '~> 2.0.2'
gem 'rails-assets-ng-table'
gem 'rails-assets-bootstrap-sass-official'
gem 'rails-assets-ng-tags-input'
gem 'rails-assets-angular-bootstrap-switch', '~> 0.3'

# ActiveRecord
gem 'rails-observers'
gem 'awesome_nested_set', '~> 3.0'
gem 'paperclip', '~> 4.2'
gem 'acts-as-taggable-on', '~> 3.4'
gem 'bcrypt'
gem 'elasticsearch-model', '~> 0.1'
gem 'elasticsearch-rails', '~> 0.1'
gem 'kaminari'
gem 'sanitize', '~> 3.1'
gem 'paranoia', '~> 2.0'
gem 'pg'
gem 'activeuuid', git: 'git@github.com:cb-talent-development/activeuuid.git'

# Authorization
gem 'six'
gem 'devise'
gem 'rack-oauth2'

# Utility
gem 'foreman', require: false
gem 'fog'
gem 'unf'
gem 'hashr'
gem 'mime-types'
gem 'json'

# Middleware
gem 'rack-cors', require: 'rack/cors'

# Jobs
gem 'sidekiq'
gem 'sidekiq-failures'
gem 'sinatra', require: false
gem 'slim' # Sidekiq-web

# Interactors
gem 'interactor-rails', '~> 2.0'

group :test, :development do
  # Environment
  gem 'dotenv'

  # Rspec
  gem 'rspec', '~> 3.1'
  gem 'rspec-rails'
  gem 'json_spec'

  # Guard
  gem 'guard-rspec'

  # Shoulda needs minitest
  gem 'minitest'

  # Mocking/Faking
  gem 'mocha', require: false
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'shoulda'
  gem 'shoulda-matchers'

  # Notifications
  gem 'rb-fsevent', require: darwin_only('rb-fsevent')
  gem 'growl', require: darwin_only('growl')
  gem 'rb-inotify', require: linux_only('rb-inotify')

  # Pretty
  gem 'awesome_print'

  gem 'jasmine-rails'
  gem 'guard-jasmine'
  gem 'jasmine-core', '~> 2.1'
  gem 'rails-assets-angular-mocks'
  gem 'rails-assets-sinonjs'
  gem 'rails-assets-sinon-ng'
  gem 'rails-assets-angular-debaser'
end

group :development do
  # Pretty
  gem 'better_errors'
  gem 'annotate'
  gem 'binding_of_caller'
  gem 'pry-rails', '~> 0.3'

  # Coverage
  gem 'rails_best_practices'

  # Server
  gem 'thin'
end

group :test do
  gem 'codeclimate-test-reporter', require: false
  gem 'timecop'
  gem 'rspec-sidekiq'
  gem 'elasticsearch-extensions'
end

group :assets do
  gem 'coffee-rails'
end

group :production do
  gem 'aws-sdk'
end

group :staging, :production do
  # Monitoring
  gem 'newrelic_rpm'
end
