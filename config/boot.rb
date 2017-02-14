ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup'

# Cache requires
begin
  puts 'Initializing bootscale..'
  require 'bootscale/setup'
rescue LoadError
  puts 'Skipping bootscale initialization - not loaded.'
end
