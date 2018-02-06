# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

ApolloTracing.start_proxy(CortexStarter.apollo_engine_proxy_config.to_json)

run Rails.application
