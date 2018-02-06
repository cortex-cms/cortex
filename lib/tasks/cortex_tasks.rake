require 'rake'

Bundler.require(:default, Rails.env)

namespace :cortex do
  desc 'Force re-creation of all elasticsearch mappings'
  task :rebuild_indexes => :environment do
    [Cortex::ContentType, Cortex::ContentItem].each do |klass|
      klass.__elasticsearch__.create_index! force: true
      klass.import
    end
  end
end
