source 'https://rubygems.org'
ruby '2.3.1'

# Dependency Management
gem 'bower-rails', '~> 0.11.0'

# Server
gem 'unicorn', '~> 5.1.0'

# Rails
gem 'rails', '~> 4.2.7'

# Cortex-specific
gem 'cortex-exceptions', '~> 0.0.4'
gem 'cortex-plugins-core', '~> 0.4.2'

# API
gem 'grape', '~> 0.17'
gem 'grape-entity', '~> 0.5.1'
gem 'grape-swagger', '~> 0.24.0'

# Authorization
gem 'six', '~> 0.2.0'
gem 'devise', '~> 4.2.0'
gem 'rack-oauth2', '~> 1.4.0'
gem 'doorkeeper', '~> 4.2'
gem 'rolify', '~> 5.1'
gem 'pundit', '~> 1.1'

# Data
gem 'rails-observers', '~> 0.1.2'
gem 'awesome_nested_set', '~> 3.1'
gem 'paperclip', '~> 5.1.0'
gem 'paperclip-optimizer', '~> 2.0'
gem 'image_optim_pack', '~> 0.3.0'
gem 'acts-as-taggable-on', '~> 4.0'
gem 'bcrypt', '~> 3.1.11'
gem 'grape-kaminari', git: 'git://github.com/toastercup/grape-kaminari', branch: 'set-only-pagination-headers'
gem 'elasticsearch-model', '~> 0.1'
gem 'elasticsearch-rails', '~> 0.1'
gem 'paranoia', '~> 2.1'
gem 'pg', '~> 0.19.0'
gem 'hashie-forbidden_attributes', '~> 0.1.1'
gem 'redis-rails', '~> 5.0'
gem 'pomona', '~> 0.7'
gem "transitions", '~> 1.2', :require => ["transitions", "active_model/transitions"]

# Middleware
gem 'rack-cors', '~> 0.4.0', require: 'rack/cors'

# Utility
gem 'excon', '~> 0.52.0'
gem 'hashie', '~> 3.4.6'
gem 'hashr', '~> 2.0.0'
gem 'mime-types', '~> 3.1.0'
gem 'interactor-rails', '~> 2.0'
gem 'virtus', '~> 1.0.5'
gem 'rubyzip', '~> 1.2.0'
gem 'addressable', '~> 2.4.0'
gem 'json'

# External Services
gem 'yt', '~> 0.25.40'
gem 'aws-sdk', '~> 2.6' # Used by Paperclip

# Jobs
gem 'sidekiq', '~> 4.2.1'
gem 'sidekiq-failures', '~> 0.4.5'
gem 'sinatra', '~> 1.4.7', require: false

# Pipeline
gem 'sprockets-rails', '3.2.0', :require => 'sprockets/railtie'
gem 'sprockets', '3.7.0'
gem 'angular-rails-templates', '~> 1.0.2'
gem 'ngannotate-rails', '~> 1.2.2'
gem 'uglifier', '~> 3.0.2'

# View
gem 'haml', '~> 4.1.0.beta'
gem 'cells', git: 'git://github.com/samstickland/cells', branch: 'collection_fix' # remove explicit 'cells' dependency when collection_fix is merged in. See: https://github.com/apotonick/cells/pull/415
gem 'cells-rails', '~> 0.0.6'
gem 'cells-haml', '~> 0.0.10'
gem 'breadcrumbs_on_rails', '~> 3.0.1'
gem 'jquery-ui-rails', '~> 5.0.5'
gem 'bootstrap-tagsinput-rails', '~> 0.4.2'

# Style
gem 'sass-rails', '~> 5.0'
gem 'bourbon', '~> 5.0.0.beta'
gem 'font-awesome-sass', '~> 4.6.2'
gem 'material_design_lite-sass', '~> 1.2.1'

# JavaScript
gem 'turbolinks', '~> 5.0.1'
gem 'jquery-turbolinks', '~> 2.1'
gem 'jquery-rails', '~> 4.2.1'
gem 'ng-rails-csrf', '~> 0.1.0'
gem 'gon', '~> 6.1.0'

group :tasks do
  # Parsing
  gem 'nokogiri'
end

group :test, :development do
  # Environment
  gem 'dotenv', '~> 2.1.1'

  # Cache/Sidekiq
  gem 'redis-namespace', '~> 1.5'

  # Debug
  gem 'byebug'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-rails'
  gem 'pry-nav'
  gem 'pry-doc'
  gem 'pry-remote'
  gem 'pry-stack_explorer'

  # Documentation
  gem "rails-erd"
end

group :test do
  # Rspec
  gem 'rspec', '~> 3.5'
  gem 'rspec-rails', '~> 3.5'
  gem 'json_spec', '~> 1.1'
  gem 'rspec-sidekiq', '~> 2.2'
  gem 'shoulda-matchers', '~> 3.1'

  # Capybara for feature testing, Poltergeist for PhantomJS
  gem 'capybara'
  gem 'poltergeist'

  # Guard
  gem 'guard-rspec', '~> 4.7'

  # Mocking/Faking
  gem 'mocha', '~> 1.1', require: false
  gem 'database_cleaner', '~> 1.5'
  gem 'timecop', '~> 0.8'
  gem 'email_spec'

  # Javascript
  gem 'guard-jasmine', '~> 2.1'
  gem 'jasmine-core', '~> 2.5'

  # Etc
  gem 'codeclimate-test-reporter', '~> 0.6', require: false
  gem 'elasticsearch-extensions', '~> 0.0.22'
end

group :test, :development do
  gem 'factory_girl_rails', '~> 4.7'
  gem 'faker', '~> 1.6'
  gem 'fog', '~> 1.38.0'
  gem 'phantomjs', '~> 2.1.1'
  gem 'jasmine-rails', '~> 0.14'
end

group :staging, :production do
  # Monitoring
  gem 'newrelic_rpm', '~> 3.16'
end
