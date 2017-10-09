Bundler.require(:default, Rails.env)

namespace :cortex do
  namespace :assets do
    namespace :webpack do
      desc 'Ensure all ReactOnRails assets are compiled'
      task ensure_all_assets_compiled: :environment do
        ReactOnRails::TestHelper.ensure_assets_compiled
      end
    end
  end
end

task 'cortex:assets:webpack:ensure_all_assets_compiled' => 'cortex:plugins:write_to_tmp'
task 'react_on_rails:assets:compile_environment' => 'cortex:plugins:write_to_tmp'

private

def webpack_for(environment)
  path = File.join(Rails.root, 'client')
  sh "cd #{path} && npm run build:#{environment}"
end
