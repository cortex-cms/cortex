source 'https://rubygems.org'

gem 'rails', '4.1.0.beta1'
gem 'rails-observers'
gem 'jbuilder', '~> 1.2'
gem 'fog'
gem 'unf'
gem 'thin', require: false
gem 'rack-cors', require: 'rack/cors'
gem 'pg'
gem 'hashr' # AppSettings
gem 'paranoia',  '~> 2.0'
gem 'kaminari'
gem 'mime-types'

# ActiveRecords
gem 'awesome_nested_set', '~> 3.0.0.rc.3'
gem 'paperclip'
gem 'acts-as-taggable-on'
gem 'bcrypt-ruby', require: 'bcrypt'
gem 'annotate'
gem 'tire'
gem 'tire_async_index'

# Sidekiq
gem 'sidekiq'
gem 'sidekiq-failures'
gem 'sinatra', require: nil
gem 'slim' # For sidekiq-web

group :test, :development do
  gem 'rspec-rails'
  gem 'mocha', require: false
  gem 'rb-fsevent', require: RUBY_PLATFORM =~ /darwin/i ? 'rb-fsevent' : false
  gem 'factory_girl_rails'
  gem 'shoulda', require: false
  gem 'database_cleaner'
end

group :development do
  gem 'pry'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'foreman', require: false
end

group :test do
  gem 'guard-rspec'
  gem 'rspec-sidekiq'
  gem 'codeclimate-test-reporter', require: nil
end

ruby '2.1.0'
