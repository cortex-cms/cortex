source 'https://rubygems.org'

gem 'rails'
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
  gem 'foreman', require: false
end

group :production do
	gem 'rails_12factor'
	gem 'pg'
end

group :test do
  gem 'mocha'
end

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

ruby "2.0.0"
