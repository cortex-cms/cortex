require 'rake'
require 'net/http'
require 'csv'
require 'aws-sdk'
require 'open-uri'

Bundler.require(:default, Rails.env)

namespace :cortex do
  namespace :plugins do
    desc 'webpack.config.js picks up on this file to build plugin assets'
    task :write_to_tmp => :environment do
      File.open('tmp/cortex_plugin_libraries.json', 'w') do |file|
        file.write(JSON.pretty_generate(Cortex.plugin_library_names))
      end
    end
  end

  desc 'Force re-creation of all elasticsearch mappings'
  task :rebuild_indexes => :environment do
    [ContentType, ContentItem].each do |klass|
      klass.__elasticsearch__.create_index! force: true
      klass.import
    end
  end
end
