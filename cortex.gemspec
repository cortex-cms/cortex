$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require 'cortex/version'

# Describe your s.add_dependency and declare its dependencies:
Gem::Specification.new do |s|
  s.name = 'cortex'
  s.version = Cortex::VERSION
  s.authors = ['CareerBuilder Employer Site & Content Products']
  s.email = 'toastercup@gmail.com'
  s.homepage = 'https://github.com/cortex-cms/cortex'
  s.summary = 'An API-driven multitenant identity, custom content distribution/management and reporting platform powered by Rails, React, GraphQL and ElasticSearch'
  s.license = 'Apache-2.0'

  s.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  s.test_files = Dir["spec/**/*"]
  s.require_paths = ["lib"]

  # Rails
  s.add_dependency 'rails', '~> 5.1.6'

  # API
  s.add_dependency 'graphql', '~> 1.7.14'
  s.add_dependency 'graphiql-rails', '~> 1.4.11'

  # Cortex-specific
  s.add_dependency 'cortex-exceptions', '= 0.0.4'

  # Service Layer
  s.add_dependency 'dry-types', '~> 0.13.2'
  s.add_dependency 'dry-struct', '~> 0.5.0'
  s.add_dependency 'dry-transaction', '~> 0.13.0'

  # Authentication
  s.add_dependency 'devise', '~> 4.4.3'

  # Authorization
  s.add_dependency 'rolify', '~> 5.2.0'
  s.add_dependency 'pundit', '~> 1.1.0'

  # Data
  s.add_dependency 'awesome_nested_set', '~> 3.1.4'
  s.add_dependency 'elasticsearch-model', '~> 5.1'
  s.add_dependency 'elasticsearch-rails', '~> 5.1'
  s.add_dependency 'elasticsearch-dsl', '~> 0.1'
  s.add_dependency 'paranoia', '~> 2.4'
  s.add_dependency 'pomona', '~> 0.7'
  s.add_dependency 'transitions', '~> 1.2'

  # Middleware
  s.add_dependency 'rack-cors', '~> 1.0.2'

  # Utility
  s.add_dependency 'hashie', '~> 3.5.7'
  s.add_dependency 'mimemagic', '~> 0.3.2'
  s.add_dependency 'addressable', '~> 2.5.2'
  s.add_dependency 'json'
  s.add_dependency 'nokogiri'

  # View
  s.add_dependency 'haml', '~> 5.0'
  s.add_dependency 'cells', '~> 4.1.7'
  s.add_dependency 'cells-rails', '~> 0.0.8'
  s.add_dependency 'cells-haml', '~> 0.0.10'
  s.add_dependency 'breadcrumbs_on_rails', '~> 3.0.1'

  # Style
  s.add_dependency 'sass-rails', '~> 5.0'

  # JavaScript
  s.add_dependency 'gon', '~> 6.2.1'
  s.add_dependency 'react_on_rails', '9.0.3'
  s.add_dependency 'mini_racer'
  s.add_dependency 'webpacker'

  # Feature Flagging
  s.add_dependency 'flipper', '~> 0.16'
  s.add_dependency 'flipper-ui', '~> 0.16'
  s.add_dependency 'flipper-active_record', '~> 0.16' # TODO: broken - need to override table prefix
end
