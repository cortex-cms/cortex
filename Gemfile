source 'https://rubygems.org'
ruby '2.4.0'

# Dependency Management
gem 'bower-rails', '~> 0.11.0'

# Server
gem 'puma', '< 3.7' # Puma 3.7.0 breaks options passed in via `rails s` - will be fixed in 3.7.1

# Rails
gem 'rails', '~> 5.0.1'

# Cortex-specific
gem 'cortex-exceptions', '= 0.0.4'
gem 'cortex-plugins-core', git: 'https://github.com/cortex-cms/cortex-plugins-core.git', branch: 'bugfix/COR-667-Media-Assets-Not-Updating' #'= 0.11.0'

# API
gem 'grape', '~> 0.17'
gem 'grape-entity', '~> 0.6.0'
gem 'grape-swagger', '~> 0.25.3'

# Authorization
gem 'six', '~> 0.2.0'
gem 'devise', '~> 4.2.0'
gem 'rack-oauth2', '~> 1.5.1'
gem 'doorkeeper', '~> 4.2'
gem 'rolify', '~> 5.1'
gem 'pundit', '~> 1.1'

# Data
gem 'rails-observers', git: 'https://github.com/triloch/rails-observers.git'
gem 'awesome_nested_set', git: 'https://github.com/cortex-cms/awesome_nested_set.git'
gem 'paperclip', '~> 5.1.0'
gem 'paperclip-optimizer', '~> 2.0'
gem 'image_optim_pack', '~> 0.3.1'
gem 'acts-as-taggable-on', '~> 4.0'
gem 'bcrypt', '~> 3.1.11'
gem 'kaminari', '~> 0.17.0'
gem 'grape-kaminari', git: 'https://github.com/toastercup/grape-kaminari.git', branch: 'set-paginate-headers-extraction'
gem 'elasticsearch-model', '~> 0.1'
gem 'elasticsearch-rails', '~> 0.1'
gem 'paranoia', '~> 2.2'
gem 'pg', '~> 0.19.0'
gem 'hashie-forbidden_attributes', '~> 0.1.1'
gem 'redis-rails', '~> 5.0'
gem 'pomona', '~> 0.7'
gem 'transitions', '~> 1.2', :require => ['transitions', 'active_model/transitions']

# Middleware
gem 'rack-cors', '~> 0.4.1', require: 'rack/cors'

# Utility
gem 'excon', '~> 0.55.0'
gem 'hashie', '~> 3.5.3'
gem 'hashr', '~> 2.0.0'
gem 'mime-types', '~> 3.1.0'
gem 'interactor-rails', '~> 2.0'
gem 'virtus', '~> 1.0.5'
gem 'rubyzip', '~> 1.2.1'
gem 'addressable', '~> 2.5.0'
gem 'json'

# External Services
gem 'yt', '~> 0.28.5'
gem 'aws-sdk', '~> 2.7' # Used by Paperclip

# Jobs
gem 'sidekiq', '~> 4.2.9'
gem 'sidekiq-failures', '~> 0.4.5'
gem 'sinatra', '~> 2.0.0.beta', require: false

# Pipeline
gem 'sprockets-rails', '3.2.0', require: 'sprockets/railtie'
gem 'sprockets', '3.7.1'
gem 'uglifier', '~> 3.0.4'
gem 'non-stupid-digest-assets', '~> 1.0.9'
gem 'angular-rails-templates', '~> 1.0.2'
gem 'ngannotate-rails', '~> 1.2.2'

# View
gem 'haml', '~> 4.1.0.beta'
gem 'cells', '~> 4.1.6'
gem 'cells-rails', '~> 0.0.7'
gem 'cells-haml', '~> 0.0.10'
gem 'breadcrumbs_on_rails', '~> 3.0.1'

# Style
gem 'sass-rails', '~> 5.0'
gem 'bourbon', '~> 4.3'
gem 'font-awesome-sass', '~> 4.7.0'
gem 'material_design_lite-sass', '~> 1.3.0'

# JavaScript
gem 'react_on_rails', '< 6.6'
gem 'mini_racer', platforms: :ruby
gem 'gon', '~> 6.1.0'
gem 'turbolinks', '~> 5.0.1'
gem 'jquery-rails', '~> 4.2.2'
gem 'jquery-turbolinks', '~> 2.1'
gem 'jquery-ui-rails', '~> 6.0.1'
gem 'ng-rails-csrf', '~> 0.1.0'
gem 'bootstrap-tagsinput-rails', '~> 0.4.2'
gem 'dialog-polyfill-rails', '~> 0.4.5'

group :tasks do
  # Parsing
  gem 'nokogiri'
end

group :test, :development do
  # Environment
  gem 'dotenv-rails', :require => 'dotenv/rails-now'
  gem 'foreman'

  # Cache/Sidekiq
  gem 'redis-namespace'

  # Debug
  gem 'byebug'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-rails'
  gem 'pry-nav'
  gem 'pry-remote'
  gem 'pry-stack_explorer'

  # Documentation
  gem 'rails-erd'
end

group :test do
  # Rspec
  gem 'rspec-rails', '~> 3.5'
  gem 'json_spec', '~> 1.1'
  gem 'rspec-sidekiq', '~> 2.2'
  gem 'shoulda-matchers', '~> 3.1'

  # Coverage
  gem 'simplecov', '~> 0.13', require: false
  gem 'codeclimate-test-reporter', '~> 0.6', require: false

  # Capybara for feature testing, Poltergeist for PhantomJS
  gem 'capybara'
  gem 'poltergeist'

  # Guard
  gem 'guard-rspec', '~> 4.7'

  # Mocking/Faking
  gem 'mocha', '~> 1.2', require: false
  gem 'database_cleaner', '~> 1.5'
  gem 'timecop', '~> 0.8'
  gem 'email_spec'

  # Javascript
  gem 'guard-jasmine', '~> 2.1'
  gem 'jasmine-core', '~> 2.5'

  # Data
  gem 'elasticsearch-extensions', '~> 0.0.26'
end

group :test, :development do
  gem 'factory_girl_rails', '~> 4.8'
  gem 'faker', '~> 1.7'
  gem 'fog', '~> 1.38.0'
  gem 'phantomjs', '~> 2.1.1'
  gem 'jasmine-rails', '~> 0.14'
end

group :staging, :production do
  # Monitoring
  gem 'newrelic_rpm', '~> 3.18'

  # Performance
  gem 'bootscale', require: false
end
