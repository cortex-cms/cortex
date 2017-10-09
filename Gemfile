source 'https://rubygems.org'
ruby '2.4.2'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Server
gem 'puma', '~> 3.10.0'

# Rails
gem 'rails', '~> 5.1.4'

# Cortex-specific
gem 'cortex-exceptions', '= 0.0.4'
gem 'cortex-plugins-core', github: 'cortex-cms/cortex-plugins-core', branch: 'topic/CE-173-Rails-5.1'

# Service Layer
gem 'dry-types', '~> 0.12.0'
gem 'dry-struct', '~> 0.3.1'
gem 'dry-transaction', '~> 0.10.2'

# Authentication
gem 'devise', '~> 4.3.0'

# Authorization
gem 'rolify', '~> 5.1.0'
gem 'pundit', '~> 1.1.0'

# Data
gem 'awesome_nested_set', '~> 3.1.3'
gem 'bcrypt', '~> 3.1.11'
gem 'kaminari', '~> 1.0.1'
gem 'elasticsearch-model', '~> 5.0'
gem 'elasticsearch-rails', '~> 5.0'
gem 'paranoia', '~> 2.3'
gem 'pg', '~> 0.21.0'
gem 'redis-rails', '~> 5.0'
gem 'pomona', '~> 0.7'
gem 'transitions', '~> 1.2', require: %w(transitions active_model/transitions)

# Middleware
gem 'rack-cors', '~> 1.0.1', require: 'rack/cors'

# Utility
gem 'hashie', '~> 3.5.6'
gem 'hashr', '~> 2.0.1'
gem 'mimemagic', '~> 0.3.2'
gem 'addressable', '~> 2.5.2'
gem 'json'
gem 'nokogiri'

# Jobs
gem 'sidekiq', '~> 5.0.5'
gem 'sidekiq-failures', '~> 1.0.0'
gem 'sinatra', '~> 2.0.0', require: false

# Pipeline
gem 'sprockets-rails', '3.2.1', require: 'sprockets/railtie'
gem 'sprockets', '3.7.1'
gem 'uglifier', '~> 3.2.0'
gem 'non-stupid-digest-assets', '~> 1.0.9'

# View
gem 'haml', '~> 5.0'
gem 'cells', '~> 4.1.7'
gem 'cells-rails', '~> 0.0.8'
gem 'cells-haml', '~> 0.0.10'
gem 'breadcrumbs_on_rails', '~> 3.0.1'

# Style
gem 'sass-rails', '~> 5.0'
gem 'bourbon', '~> 4.3'
gem 'font-awesome-sass', '~> 4.7.0'
gem 'material_design_lite-sass', '~> 1.3.0'

# JavaScript
gem 'react_on_rails', '8.0.6'
gem 'mini_racer', platforms: :ruby
gem 'webpacker_lite'
gem 'gon', '~> 6.2.0'
#gem 'turbolinks', '~> 5.0.1'
gem 'jquery-rails', '~> 4.3.1'
#gem 'jquery-turbolinks', '~> 2.1'
gem 'jquery-ui-rails', '~> 6.0.1'
gem 'bootstrap-tagsinput-rails', '~> 0.4.2'
gem 'dialog-polyfill-rails', '~> 0.4.5'

# Feature Flagging
gem 'flipper', '~> 0.10'
gem 'flipper-ui', '~> 0.10'
gem 'flipper-active_record', '~> 0.10'

group :development, :test do
  # Environment
  gem 'dotenv-rails', require: 'dotenv/rails-now'
  gem 'foreman'

  # Cache/Sidekiq
  gem 'redis-namespace'

  # Debug
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-rails'
  gem 'pry-nav'
  gem 'pry-remote'
  gem 'pry-stack_explorer'

  # Specs
  gem 'rspec-rails'
  gem 'guard-rspec', require: false
  gem 'database_cleaner'

  # Documentation
  gem 'rails-erd'
end

group :development do
  # Debug
  gem 'better_errors'
  gem 'binding_of_caller'

  # Misc
  gem 'listen', '>= 3.0.5', '< 3.2'
end

group :test do
  # Rspec
  gem 'json_spec', '~> 1.1'
  gem 'rspec-sidekiq', '~> 3.0'
  gem 'shoulda-matchers', '~> 3.1'

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
  gem 'elasticsearch-extensions', '~> 0.0.26'
end

group :test, :development do
  gem 'factory_girl_rails', '~> 4.8'
  gem 'faker', '~> 1.8'
  gem 'phantomjs', '~> 2.1'
  gem 'jasmine-rails', '~> 0.14'
end

group :staging, :production do
  # Monitoring
  gem 'newrelic_rpm'
  gem 'sentry-raven'

  # Performance
  gem 'bootscale', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
