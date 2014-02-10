source 'https://rubygems.org'

def darwin_only(require_as)
  RUBY_PLATFORM.include?('darwin') && require_as
end

def linux_only(require_as)
  RUBY_PLATFORM.include?('linux') && require_as
end

# Rails
gem 'rails', '4.1.0.beta1'

# Templating
gem 'jbuilder', '~> 1.2'

# ActiveRecord
gem 'rails-observers'
gem 'awesome_nested_set', '~> 3.0.0.rc.3'
gem 'paperclip'
gem 'acts-as-taggable-on'
gem 'bcrypt-ruby', require: 'bcrypt'
gem 'tire'
gem 'tire_async_index'
gem 'kaminari'
gem 'paranoia',  '~> 2.0'
gem 'pg'

# Authorization
gem 'devise'

# Utility
gem 'foreman', require: false 
gem 'fog'
gem 'unf'
gem 'hashr'
gem 'mime-types'

# Middleware
gem 'rack-cors', require: 'rack/cors'

# Sidekiq
gem 'sidekiq'
gem 'sidekiq-failures'
gem 'sinatra', require: nil
gem 'slim' # Sidekiq-web

gem 'minitest'

group :test, :development do

  # Rspec
  gem 'rspec-sidekiq'
  gem 'rspec-rails'

  # Guard
  gem 'guard-rspec'

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
  gem 'ruby-debug-ide'
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
  gem 'codeclimate-test-reporter', require: nil
  gem 'timecop'
end

ruby '2.1.0'
