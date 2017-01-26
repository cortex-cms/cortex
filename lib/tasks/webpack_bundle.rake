Bundler.require(:default, Rails.env)

namespace :cortex do
  namespace :assets do
    desc 'Ensure all ReactOnRails assets are compiled'
    task ensure_all_assets_compiled: :environment do
      ReactOnRails::TestHelper.ensure_assets_compiled
      # TODO: Loop through each Plugin and pass client_dir to ensure_assets_compiled
    end

    namespace :webpack do
      namespace :all do
        desc 'Build Webpack bundle for Cortex and all loaded plugins'
        task :build => :environment do
          all_webpack_threading_for('development')
        end

        desc 'Compile Webpack bundle for Cortex and all loaded plugins'
        task :compile => :environment do
          all_webpack_threading_for('production')
        end
      end
    end
  end
end

private

def all_webpack_threading_for(environment)
  path = File.join(Rails.root, 'client')
  threads = [webpack_thread(path, environment)]
  plugins.each do |plugin|
    path = File.join(plugin::Engine.root, 'client')
    threads << webpack_thread(path, environment)
  end
  trap_for_thread_exit(threads)
  ThreadsWait.all_waits(*threads)
end

def webpack_thread(path, environment)
  Thread.new do
    sh "cd #{path} && npm run build:#{environment}"
  end
end

def plugins
  Cortex::Plugins.constants.map(&Cortex::Plugins.method(:const_get)).grep(Class)
end

def trap_for_thread_exit(threads)
  # Trap ctrl-c and kill threads on exit
  trap('INT') {
    puts "\nKilling Webpack threads.."
    threads.each do |thread|
      Thread.kill thread
    end
  }
end
