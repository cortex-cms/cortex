source 'https://rubygems.org'

gem 'rails', '~> 4.0'
gem 'jbuilder', '~> 1.2'
gem 'fog'
gem 'unf'
gem 'thin', require: false
gem 'rack-cors', require: 'rack/cors'

# ActiveRecord
gem 'apartment'
gem 'awesome_nested_set'
gem 'paperclip', '~> 3.0'
gem 'acts-as-taggable-on'
gem 'bcrypt-ruby', require: 'bcrypt'
gem 'annotate'

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
  gem 'rspec-sidekiq'
end

group :development do
  gem 'better_errors'
  gem 'foreman', require: false
end

group :production do
  gem 'rails_12factor'
  gem 'pg'
end

group :test do
  gem 'guard-rspec'
end

ruby '2.0.0'
