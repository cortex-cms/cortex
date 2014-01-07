namespace :tddium do

  desc "tddium environment db setup task"
  task :db_hook do
    ENV['RAILS_ENV'] = 'test'
    # Uncomment the line for your DB
    Rake::Task["tddium:db:load:mysql"].invoke
    # Rake::Task["tddium:db:load:postgresql"].invoke
    # Rake::Task["tddium:db:load:schema"].invoke
    Rake::Task["db:migrate"].invoke
  end

  namespace :db do
    def files_differ(*files)
      result = files.map do |fn|
        Digest::SHA1.hexdigest(File.read(fn)) rescue "invalid"
      end.inject(Hash.new(0)) do |hash, i|
        hash[i] += 1
        hash
      end
      result.size > 1
    end

    def schema_lookup_at(dirname, pattern) #:nodoc:
      Dir.glob("#{dirname}/#{pattern % '[0-9]*'}")
    end

    def current_schema_number(dirname, pattern) #:nodoc:
      schema_lookup_at(dirname, pattern).collect do |file|
        File.basename(file).split("-").last.to_i
      end.max.to_i
    end

    def schema_names(dirname, pattern) #:nodoc:
      current = current_schema_number(dirname, pattern)
      next_schema_number = current + 1
      next_schema_number = [Time.now.utc.strftime("%Y%m%d%H%M%S"), "%.14d" % next_schema_number].max
      [pattern % current, pattern % next_schema_number]
    end

    desc "Capture schema state if it has changed (always with FORCE=true). To be run from git pre-commit hook."
    task :capture => :environment do
      SCHEMA_DIR = "db/schema/"

      if defined?(ActiveRecord) && !ActiveRecord::Base.configurations.blank?
        branch = File.basename(`git symbolic-ref HEAD`.gsub("\n", ""))

        extension = {:sql=>"sql", :ruby=>"rb"}[ActiveRecord::Base.schema_format]
        schema_tmpl = "#{branch}-%s.#{extension}"

        current_filename, next_filename = schema_names(SCHEMA_DIR, schema_tmpl)

        tmp_filename = File.join(Dir::tmpdir, next_filename)
        schema_filename = File.join(SCHEMA_DIR, next_filename)
        current_filename = File.join(SCHEMA_DIR, current_filename)

        if ActiveRecord::Base.schema_format == :sql
          STDERR.puts "Examining schema as SQL..."
          Rake::Task["db:structure:dump"].invoke
          FileUtils.copy("db/#{Rails.env}_structure.sql", tmp_filename)
        elsif ActiveRecord::Base.schema_format == :ruby
          STDERR.puts "Examining schema as Ruby..."
          ENV["SCHEMA"] = tmp_filename
          Rake::Task["db:schema:dump"].invoke
        else
          raise "Unsupported schema format: #{ActiveRecord::Base.schema_format}"
        end

        # if the new schema is the same as the latest one, don't generate a
        # redundant commit
        if ENV["FORCE"] || files_differ(tmp_filename, current_filename)
          STDERR.puts "Schema change detected.  Creating #{schema_filename} and adding to commit."
          FileUtils.mkdir_p(SCHEMA_DIR)
          FileUtils.copy(tmp_filename, schema_filename)

          raise "Couldn't add #{schema_filename} to commit" unless system("git add #{schema_filename}")
        else
          STDERR.puts "No schema change detected."
        end

      end
    end

    namespace :load do
      desc "Load schema from ruby capture file"
      task :schema do
        branch = File.basename(`git symbolic-ref HEAD`.gsub("\n", ""))
        fn = Dir.glob("db/schema/#{branch}-[0-9]*.rb").sort.last
        Rake::Task["db:create"].invoke
        ENV["SCHEMA"] = fn
        Rake::Task["db:schema:load"].invoke
      end

      desc "Load SQL into MySQL"
      task :mysql do
        branch = File.basename(`git symbolic-ref HEAD`.gsub("\n", ""))
        fn = Dir.glob("db/schema/#{branch}-[0-9]*.sql").sort.last
        Rake::Task["db:create"].invoke
        cmd = "mysql --user=#{ENV['TDDIUM_DB_USER']} #{ENV['TDDIUM_DB_NAME']} < #{fn} 2>&1"
        puts cmd
        raise "Couldn't load schema #{fn}" unless system(cmd)
      end

      desc "Load SQL into Postgresql"
      task :postgresql do
        branch = File.basename(`git symbolic-ref HEAD`.gsub("\n", ""))
        fn = Dir.glob("db/schema/#{branch}-[0-9]*.sql").sort.last
        Rake::Task["db:create"].invoke
        cmd = "psql -U #{ENV['TDDIUM_DB_USER']} #{ENV['TDDIUM_DB_NAME']} < #{fn} 2>&1"
        puts cmd
        raise "Couldn't load schema #{fn}" unless system(cmd)
      end
    end
  end
end
