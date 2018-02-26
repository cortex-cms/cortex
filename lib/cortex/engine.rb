require 'devise'
require 'elasticsearch/rails/instrumentation'
require 'flipper'
require 'flipper-active_record'
require 'transitions'
require 'active_model/transitions'
require 'paranoia'
require 'rolify'
require 'breadcrumbs_on_rails'
require 'awesome_nested_set'
require 'react_on_rails'
require 'cells-rails'
require 'cells-haml'
require 'graphiql/rails'
require 'pomona'
require 'rack/cors'
require 'dry-struct'

module Cortex
  class Engine < ::Rails::Engine
    isolate_namespace Cortex

    initializer "cortex.precompile_manifest" do |app|
      app.config.assets.precompile += %w(cortex_manifest)
    end

    initializer "cortex.add_middleware" do |app|
      # Insert Rack::CORS as the first middleware
      app.config.middleware.insert_before 0, Rack::Cors do
        allow do
          origins *((Cortex.config[:cors][:allowed_origins] || '*').split(',') +
            [Cortex.config[:cors][:allowed_origins_regex] || ''])
          resource '*',
                   :headers => :any,
                   :methods => [:get, :post, :options]
        end
      end
    end
  end
end
