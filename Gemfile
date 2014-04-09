source 'https://rubygems.org'

ruby '2.1.1'

def darwin_only(require_as)
  RUBY_PLATFORM.include?('darwin') && require_as
end

def linux_only(require_as)
  RUBY_PLATFORM.include?('linux') && require_as
end

# Rails
gem 'rails', '4.1.0.beta1'

# API
gem 'grape', git: 'git://github.com/intridea/grape'
gem 'grape-entity'
gem 'grape-swagger'
gem 'doorkeeper', git: 'git://github.com/applicake/doorkeeper'

# Templating
gem 'haml'

# Style
gem 'sass-rails'
gem 'bootstrap-sass'
gem 'font-awesome-sass'

# Locked to 2.11.0 until the following issue is closed
# https://github.com/rails/sass-rails/issues/191
gem 'sprockets', '2.11.0'

# JS
gem 'angularjs-rails'
gem 'jquery-rails'
gem 'uglifier'

# ActiveRecord
gem 'rails-observers'
gem 'awesome_nested_set', '~> 3.0.0.rc.3'
gem 'paperclip'
gem 'acts-as-taggable-on', '~> 3.0.2'
gem 'bcrypt-ruby', require: 'bcrypt'
gem 'tire'
gem 'tire_async_index'
gem 'kaminari'
gem 'paranoia',  '~> 2.0'
gem 'pg'


# Mongoid
gem 'mongoid', '~> 4.0.0.beta1', git: 'git://github.com/mongoid/mongoid'
gem 'bson_ext'
gem 'mongoid-paranoia', github: 'simi/mongoid-paranoia'

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

# Sidekiq
gem 'sidekiq', '~> 2.17.6'
gem 'sidekiq-failures'
gem 'sinatra', require: false
gem 'slim' # Sidekiq-web

group :test, :development do

  # Rspec
  gem 'rspec-sidekiq'
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
  gem 'pry'
  gem 'awesome_print'

  # IDE
  gem 'ruby-debug-ide', require: false
end

group :development do
  # Pretty
  gem 'better_errors'
  gem 'annotate'
  gem 'binding_of_caller'

  # Coverage
  gem 'rails_best_practices'

  # Server
  gem 'thin'
end

group :test do
  gem 'codeclimate-test-reporter', require: false
  gem 'timecop'
end
