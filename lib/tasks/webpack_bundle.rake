Bundler.require(:default, Rails.env)

namespace :cortex do
  namespace :assets do
    desc 'Ensure all ReactOnRails assets are compiled'
    task ensure_all_assets_compiled: :environment do
      ReactOnRails::TestHelper.ensure_assets_compiled
      # TODO: Loop through each Plugin and pass client_dir to ensure_assets_compiled
    end

    namespace :webpack do
      desc 'Run Webpack for Cortex and all loaded plugins'
      task :build_all => :environment do
        threads = []
        plugins.each do |plugin|
          path = File.join(plugin::Engine.root, 'client')
          threads << Thread.new(task.to_s) do
            sh "cd #{path} && #{ReactOnRails.configuration.npm_build_production_command}"
          end
        end
      end

      desc 'Run Webpack for Cortex and all loaded plugins'
      task :compile_all => :environment do
        threads = []
        webpack_compile_tasks.each do |task|
          threads << Thread.new(task.to_s) do
            task.invoke
          end
        end

        threads.each do |thread|
          thread.join 5
        end
      end
    end
  end
end

private

def plugins
  Cortex::Plugins.constants.map(&Cortex::Plugins.method(:const_get)).grep(Class)
end

def webpack_compile_tasks
  Rake.application.tasks.select do |task|
    task.to_s.include? 'assets:webpack'
  end
end
