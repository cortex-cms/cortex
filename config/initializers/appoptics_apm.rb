# frozen_string_literal: true

# Copyright (c) 2019 SolarWinds, LLC.
# All rights reserved.

# AppOpticsAPM Initializer (for the appoptics_apm gem)
# https://www.appoptics.com/
#
# More information on instrumenting Ruby applications can be found here:
# https://docs.appoptics.com/kb/apm_tracing/ruby/
#
# The settings in this template file represent the defaults

if defined?(AppOpticsAPM::Config)

  # :service_key, :hostname_alias, :http_proxy, and :debug_level
  # are startup settings and can't be changed afterwards.

  #
  # Set APPOPTICS_SERVICE_KEY
  # This setting will be overridden if APPOPTICS_SERVICE_KEY is set as an environment variable.
  # This is a required setting. If the service key is not set here it needs to be set as environment variable.
  #
  # The service key is a combination of the API token plus a service name.
  # E.g.: 0123456789abcde0123456789abcde0123456789abcde0123456789abcde1234:my_service
  #
  # AppOpticsAPM::Config[:service_key] = '0123456789abcde0123456789abcde0123456789abcde0123456789abcde1234:my_service'

  #
  # Set APPOPTICS_HOSTNAME_ALIAS
  # This setting will be overridden if APPOPTICS_HOSTNAME_ALIAS is set as an environment variable
  #
  # AppOpticsAPM::Config[:hostname_alias] = 'alias_name'

  #
  # Set Proxy for AppOptics
  # This setting will be overridden if APPOPTICS_PROXY is set as an environment variable.
  #
  # Please configure http_proxy if a proxy needs to be used to communicate with
  # the AppOptics backend.
  # The format should either be http://<proxyHost>:<proxyPort> for a proxy
  # server that does not require authentication, or
  # http://<username>:<password>@<proxyHost>:<proxyPort> for a proxy server that
  # requires basic authentication.
  #
  # Note that while HTTP is the only type of connection supported, the traffic
  # to AppOptics is still encrypted using SSL/TLS.
  #
  # It is recommended to configure the proxy in this file or as APPOPTICS_PROXY
  # environment variable. However, the agent's underlying network library will
  # use a system-wide proxy defined in the environment variables grpc_proxy,
  # https_proxy or http_proxy if no AppOptics-specific configuration is set.
  # Please refer to gRPC environment variables for more information.
  #
  # AppOpticsAPM::Config[:http_proxy] = http://<proxyHost>:<proxyPort>

  #
  # Set APPOPTICS_DEBUG_LEVEL
  # This setting will be overridden if APPOPTICS_DEBUG_LEVEL is set as an environment variable.
  #
  # It sets the log level and takes the following values:
  # -1 disabled, 0 fatal, 1 error, 2 warning, 3 info (the default), 4 debug low, 5 debug medium, 6 debug high.
  # Values out of range (< -1 or > 6) are ignored and the log level is set to the default (info).
  #
  AppOpticsAPM::Config[:debug_level] = 3

  #
  # :debug_level will be used in the c-extension of the gem and also mapped to the
  # Ruby logger as DISABLED, FATAL, ERROR, WARN, INFO, or DEBUG
  # The Ruby logger can afterwards be changed to a different level, e.g:
  # AppOpticsAPM.logger.level = Logger::INFO

  #
  # Set APPOPTICS_GEM_VERBOSE
  # This setting will be overridden if APPOPTICS_GEM_VERBOSE is set as an environment variable
  #
  # On startup the components that are being instrumented will be reported if this is set to true.
  # If true and the log level is 4 or higher this may create extra debug log messages
  #
  AppOpticsAPM::Config[:verbose] = false

  #
  # Turn code profiling on or off
  #
  # By default profiling is set to :disabled, the other option is :enabled.
  # :enabled means that any traced code will also be profiled to get deeper insight
  # into the methods called during a trace.
  # Profiling in the appoptics_apm gem is based on the low-overhead, sampling
  # profiler implemented in stackprof.
  #
  AppOpticsAPM::Config[:profiling] = :disabled

  #
  # Set the profiling interval (in milliseconds)
  #
  # The default is 10 milliseconds, which means that the method call stack is
  # recorded every 10 milliseconds. Shorter intervals may give better insight,
  # but will incur more overhead.
  # Minimum: 1, Maximum: 100
  #
  AppOpticsAPM::Config[:profiling_interval] = 10

  #
  # Turn Tracing on or off
  #
  # By default tracing is set to :enabled, the other option is :disabled.
  # :enabled means that sampling will be done according to the current
  # sampling rate and metrics are reported.
  # :disabled means that there is no sampling and metrics are not reported.
  #
  # The values :always and :never are deprecated
  #
  AppOpticsAPM::Config[:tracing_mode] = :enabled

  #
  # Turn Trigger Tracing on or off
  #
  # By default trigger tracing is :enabled, the other option is :disabled.
  # It allows to use the X-Trace-Options header to force a request to be
  # traced (within rate limits set for trigger tracing)
  #
  AppOpticsAPM::Config[:trigger_tracing_mode] = :enabled

  #
  # Trace Context in Logs
  #
  # Configure if and when the Trace ID should be included in application logs.
  # Common Ruby and Rails loggers are auto-instrumented, so that they can include
  # the current Trace ID in log messages.
  #
  # The added string will look like: "ao.traceId=7435A9FE510AE4533414D425DADF4E180D2B4E36-0"
  # It ends in '-1' if the request is sampled and in '-0' otherwise.
  #
  # The following options are available:
  # :never    (default)
  # :sampled  only include the Trace ID of sampled requests
  # :traced   include the Trace ID for all traced requests
  # :always   always add a Trace ID, it will be '0000000000000000000000000000000000000000-0'
  #           when there is no tracing context.
  #
  AppOpticsAPM::Config[:log_traceId] = :never

  #
  # Prepend Domain to Transaction Name
  #
  # If this is set to `true` transaction names will be composed as
  # `my.host.com/controller.action` instead of `controller.action`.
  # This configuration applies to all transaction names, whether deduced by the
  # instrumentation or implicitly set.
  #
  AppOpticsAPM::Config[:transaction_name][:prepend_domain] = false

  #
  # Sanitize SQL Statements
  #
  # The AppOpticsAPM Ruby client has the ability to sanitize query literals
  # from SQL statements.  By default this is enabled.  Disable to
  # collect and report query literals to AppOpticsAPM.
  #
  AppOpticsAPM::Config[:sanitize_sql] = true
  AppOpticsAPM::Config[:sanitize_sql_regexp] = '(\'[^\']*\'|\d*\.\d+|\d+|NULL)'
  AppOpticsAPM::Config[:sanitize_sql_opts]   = Regexp::IGNORECASE

  #
  # Do Not Trace - DNT
  #
  # DEPRECATED
  # Please comment out if no filtering is desired, e.g. your static
  # assets are served by the web server and not the application
  #
  # This configuration allows creating a regexp for paths that should be excluded
  # from appoptics processing.
  #
  # For example:
  # - static assets that aren't served by the web server, or
  # - healthcheck endpoints that respond to a heart beat.
  #
  # :dnt_regexp is the regular expression that is applied to the incoming path
  # to determine whether the request should be measured and traced or not.
  #
  # :dnt_opts can be commented out, nil, or Regexp::IGNORECASE
  #
  # The matching happens before routes are applied.
  # The path originates from the rack layer and is retrieved as follows:
  #   req = ::Rack::Request.new(env)
  #   path = URI.unescape(req.path)
  #
  AppOpticsAPM::Config[:dnt_regexp] = '\.(jpg|jpeg|gif|png|ico|css|zip|tgz|gz|rar|bz2|pdf|txt|tar|wav|bmp|rtf|js|flv|swf|otf|eot|ttf|woff|woff2|svg|less)(\?.+){0,1}$'
  AppOpticsAPM::Config[:dnt_opts] = Regexp::IGNORECASE

  #
  # GraphQL
  #
  # Enable tracing for GraphQL.
  # (true | false, default: true)
  AppOpticsAPM::Config[:graphql][:enabled] = true
  # Replace query arguments with a '?' when sent with a trace.
  # (true | false, default: true)
  AppOpticsAPM::Config[:graphql][:sanitize] = true
  # Remove comments from queries when sent with a trace.
  # (true | false, default: true)
  AppOpticsAPM::Config[:graphql][:remove_comments] = true
  # Create a transaction name by combining
  # "query" or "mutation" with the first word of the query.
  # This overwrites the default transaction name, which is a combination of
  # controller + action and would be the same for all graphql queries.
  # (true | false, default: true)
  AppOpticsAPM::Config[:graphql][:transaction_name] = true

  #
  # Rack::Cache
  #
  # Create a transaction name like `rack-cache.<cache-store>`,
  # e.g. `rack-cache.memcached`
  # This can reduce the number of transaction names, when many requests are
  # served directly from the cache without hitting a controller action.
  # When set to `false` the path will be used for the transaction name.
  #
  AppOpticsAPM::Config[:rack_cache] = { transaction_name: true }

  #
  # Transaction Settings
  #
  # Use this configuration to add exceptions to the global tracing mode and
  # disable/enable metrics and traces for certain transactions.
  #
  # Currently allowed hash keys:
  # :url to apply listed filters to urls.
  #      The matching of settings to urls happens before routes are applied.
  #      The url is extracted from the env argument passed to rack: `env['PATH_INFO']`
  #
  # and the hashes within the :url list either:
  #   :extensions  takes an array of strings for filtering (not regular expressions!)
  #   :tracing     defaults to :disabled, can be set to :enabled to override
  #              the global :disabled setting
  # or:
  #   :regexp      is a regular expression that is applied to the incoming path
  #   :opts        (optional) nil(default) or Regexp::IGNORECASE (options for regexp)
  #   :tracing     defaults to :disabled, can be set to :enabled to override
  #              the global :disabled setting
  #
  # Be careful not to add too many :regexp configurations as they will slow
  # down execution.
  #
  AppOpticsAPM::Config[:transaction_settings] = {
    url: [
      #   {
      #     extensions: %w['long_job'],
      #     tracing: :disabled
      #   },
      #   {
      #     regexp: '^.*\/long_job\/.*$',
      #     opts: Regexp::IGNORECASE,
      #     tracing: :disabled
      #   },
      #   {
      #     regexp: /batch/,
      #   }
    ]
  }

  #
  # Blacklist urls
  #
  # This configuration is used by outbound calls. If the call
  # goes to a blacklisted url then we won't add any
  # tracing information to the headers.
  #
  # The list has to an array of strings, even if only one url is blacklisted
  #
  # Example: AppOpticsAPM::Config[:blacklist] = ['google.com']
  #
  AppOpticsAPM::Config[:blacklist] = []

  #
  # Rails Exception Logging
  #
  # In Rails, raised exceptions with rescue handlers via
  # <tt>rescue_from</tt> are not reported to the AppOptics
  # dashboard by default.  Setting this value to true will
  # report all raised exceptions regardless.
  #
  AppOpticsAPM::Config[:report_rescued_errors] = false

  #
  # EC2 Metadata Fetching Timeout
  #
  # The timeout can be in the range 0 - 3000 (milliseconds)
  # Setting to 0 milliseconds effectively disables fetching from
  # the metadata URL (not waiting), and should only be used if
  # not running on EC2 / Openstack to minimize agent start up time.
  #
  AppOpticsAPM::Config[:ec2_metadata_timeout] = 1000

  #############################################
  ## SETTINGS FOR INDIVIDUAL GEMS/FRAMEWORKS ##
  #############################################

  #
  # Bunny Controller and Action
  #
  # The bunny (Rabbitmq) instrumentation can optionally report
  # Controller and Action values to allow filtering of bunny
  # message handling in # the UI.  Use of Controller and Action
  # for filters is temporary until the UI is updated with
  # additional filters.
  #
  # These values identify which properties of
  # Bunny::MessageProperties to report as Controller
  # and Action.  The defaults are to report :app_id (as
  # Controller) and :type (as Action).  If these values
  # are not specified in the publish, then nothing
  # will be reported here.
  #
  AppOpticsAPM::Config[:bunnyconsumer][:controller] = :app_id
  AppOpticsAPM::Config[:bunnyconsumer][:action] = :type

  #
  # Enabling/Disabling Instrumentation
  #
  # If you're having trouble with one of the instrumentation libraries, they
  # can be individually disabled here by setting the :enabled
  # value to false.
  #
  # :enabled settings are read on startup and can't be changed afterwards
  #
  AppOpticsAPM::Config[:action_controller][:enabled] = true
  AppOpticsAPM::Config[:action_controller_api][:enabled] = true
  AppOpticsAPM::Config[:action_view][:enabled] = true
  AppOpticsAPM::Config[:active_record][:enabled] = true
  AppOpticsAPM::Config[:bunnyclient][:enabled] = true
  AppOpticsAPM::Config[:bunnyconsumer][:enabled] = true
  AppOpticsAPM::Config[:cassandra][:enabled] = true
  AppOpticsAPM::Config[:curb][:enabled] = true
  AppOpticsAPM::Config[:dalli][:enabled] = true
  AppOpticsAPM::Config[:delayed_jobclient][:enabled] = true
  AppOpticsAPM::Config[:delayed_jobworker][:enabled] = true
  # AppOpticsAPM::Config[:em_http_request][:enabled] = false # not supported anymore
  AppOpticsAPM::Config[:excon][:enabled] = true
  AppOpticsAPM::Config[:faraday][:enabled] = true
  AppOpticsAPM::Config[:grpc_client][:enabled] = true
  AppOpticsAPM::Config[:grpc_server][:enabled] = true
  AppOpticsAPM::Config[:grape][:enabled] = true
  AppOpticsAPM::Config[:httpclient][:enabled] = true
  AppOpticsAPM::Config[:memcached][:enabled] = true
  AppOpticsAPM::Config[:mongo][:enabled] = true
  AppOpticsAPM::Config[:moped][:enabled] = true
  AppOpticsAPM::Config[:nethttp][:enabled] = true
  AppOpticsAPM::Config[:padrino][:enabled] = true
  AppOpticsAPM::Config[:rack][:enabled] = true
  AppOpticsAPM::Config[:redis][:enabled] = true
  AppOpticsAPM::Config[:resqueclient][:enabled] = true
  AppOpticsAPM::Config[:resqueworker][:enabled] = true
  AppOpticsAPM::Config[:rest_client][:enabled] = true
  AppOpticsAPM::Config[:sequel][:enabled] = true
  AppOpticsAPM::Config[:sidekiqclient][:enabled] = true
  AppOpticsAPM::Config[:sidekiqworker][:enabled] = true
  AppOpticsAPM::Config[:sinatra][:enabled] = true
  AppOpticsAPM::Config[:typhoeus][:enabled] = true

  #
  # Argument logging
  #
  #
  # For http requests:
  # By default the query string parameters are included in the URLs reported.
  # Set :log_args to false and instrumentation will stop collecting
  # and reporting query arguments from URLs.
  #
  AppOpticsAPM::Config[:bunnyconsumer][:log_args] = true
  AppOpticsAPM::Config[:curb][:log_args] = true
  AppOpticsAPM::Config[:excon][:log_args] = true
  AppOpticsAPM::Config[:httpclient][:log_args] = true
  AppOpticsAPM::Config[:mongo][:log_args] = true
  AppOpticsAPM::Config[:nethttp][:log_args] = true
  AppOpticsAPM::Config[:rack][:log_args] = true
  AppOpticsAPM::Config[:resqueclient][:log_args] = true
  AppOpticsAPM::Config[:resqueworker][:log_args] = true
  AppOpticsAPM::Config[:sidekiqclient][:log_args] = true
  AppOpticsAPM::Config[:sidekiqworker][:log_args] = true
  AppOpticsAPM::Config[:typhoeus][:log_args] = true

  #
  # Enabling/Disabling Backtrace Collection
  #
  # Instrumentation can optionally collect backtraces as they collect
  # performance metrics.  Note that this has a negative impact on
  # performance but can be useful when trying to locate the source of
  # a certain call or operation.
  #
  AppOpticsAPM::Config[:action_controller][:collect_backtraces] = true
  AppOpticsAPM::Config[:action_controller_api][:collect_backtraces] = true
  AppOpticsAPM::Config[:action_view][:collect_backtraces] = true
  AppOpticsAPM::Config[:active_record][:collect_backtraces] = true
  AppOpticsAPM::Config[:bunnyclient][:collect_backtraces] = false
  AppOpticsAPM::Config[:bunnyconsumer][:collect_backtraces] = false
  AppOpticsAPM::Config[:cassandra][:collect_backtraces] = true
  AppOpticsAPM::Config[:curb][:collect_backtraces] = true
  AppOpticsAPM::Config[:dalli][:collect_backtraces] = false
  AppOpticsAPM::Config[:delayed_jobclient][:collect_backtraces] = false
  AppOpticsAPM::Config[:delayed_jobworker][:collect_backtraces] = false
  # AppOpticsAPM::Config[:em_http_request][:collect_backtraces] = true # not supported anymore
  AppOpticsAPM::Config[:excon][:collect_backtraces] = true
  AppOpticsAPM::Config[:faraday][:collect_backtraces] = false
  AppOpticsAPM::Config[:grape][:collect_backtraces] = true
  AppOpticsAPM::Config[:grpc_client][:collect_backtraces] = false
  AppOpticsAPM::Config[:grpc_server][:collect_backtraces] = false
  AppOpticsAPM::Config[:httpclient][:collect_backtraces] = true
  AppOpticsAPM::Config[:memcached][:collect_backtraces] = false
  AppOpticsAPM::Config[:mongo][:collect_backtraces] = true
  AppOpticsAPM::Config[:moped][:collect_backtraces] = true
  AppOpticsAPM::Config[:nethttp][:collect_backtraces] = true
  AppOpticsAPM::Config[:padrino][:collect_backtraces] = true
  AppOpticsAPM::Config[:rack][:collect_backtraces] = true
  AppOpticsAPM::Config[:redis][:collect_backtraces] = false
  AppOpticsAPM::Config[:resqueclient][:collect_backtraces] = true
  AppOpticsAPM::Config[:resqueworker][:collect_backtraces] = true
  AppOpticsAPM::Config[:rest_client][:collect_backtraces] = true
  AppOpticsAPM::Config[:sequel][:collect_backtraces] = true
  AppOpticsAPM::Config[:sidekiqclient][:collect_backtraces] = false
  AppOpticsAPM::Config[:sidekiqworker][:collect_backtraces] = false
  AppOpticsAPM::Config[:sinatra][:collect_backtraces] = true
  AppOpticsAPM::Config[:typhoeus][:collect_backtraces] = false

end
