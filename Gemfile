source 'https://rubygems.org'

gem 'rails'
gem 'jbuilder', '~> 1.2'

# ActiveRecord
gem 'apartment'
gem 'awesome_nested_set'
gem "paperclip", '~> 3.0'
gem 'acts-as-taggable-on'
gem 'bcrypt-ruby', require: 'bcrypt'

gem 'rack-cors', require: 'rack/cors'

# Sidekiq
gem 'sidekiq'
gem 'sidekiq-failures'
gem 'sinatra', require: nil
gem 'slim' # For sidekiq-web

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
  gem 'better_errors'
  gem 'sqlite3'
end

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem "mocha", group: :test
