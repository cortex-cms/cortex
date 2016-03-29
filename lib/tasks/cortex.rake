require 'rake'
require 'net/http'
require 'csv'
require 'open-uri'

Bundler.require(:default, Rails.env)

namespace :cortex do
  desc 'Add categories from seeds.yml'
  task :create_categories => :environment do
    user = User.find_by_email(SeedData.cortex_tenant.creator.email)
    SeedData.categories.each do |parent_category_seed|
      parent = Category.find_by_name(parent_category_seed[:name])
      unless parent
        puts "Creating #{parent_category_seed[:name]}"
        parent = Category.create(name: parent_category_seed[:name], user_id: user.id)
      end
      parent_category_seed[:children].each do |child_category_seed|
        child = Category.find_by(name: child_category_seed[:name], parent_id: parent.id)
        unless child
          puts "  Creating #{child_category_seed[:name]}"
          Category.create(name: child_category_seed[:name], parent_id: parent.id, user_id: user.id)
        end
      end
    end
  end

  desc 'Force re-creation of all elasticsearch mappings'
  task :rebuild_indexes => :environment do
    [Post, Media, Onet::Occupation, Webpage, User].each do |klass|
      klass.__elasticsearch__.create_index! force: true
      klass.import
    end
  end

  namespace :snippets do

    desc 'Find and replace text in snippets'
    task :replace => :environment do

      find = ENV['FIND']
      replace = ENV['REPLACE']
      tenant = ENV['TENANT']

      if [find, replace, tenant].include? nil
        puts "You need to set env vars for FIND, REPLACE and TENANT to use this"
        next
      end

      # Replace text in Snippets and in Posts
      puts "Searching for Snippets with the text '#{find}' in tenant #{tenant}"
      matching_snippets = Snippet.find_by_tenant_id(tenant).find_by_body_text(find)

      puts "Searching for Posts with the text '#{find}' in tenant #{tenant}"
      matching_posts = Post.find_by_tenant_id(tenant).find_by_body_text(find)

      puts "This will replace text in #{matching_snippets.count} snippet(s) and #{matching_posts.count} post(s)"

      puts "Would you like to continue? (yes)"
      confirmation = STDIN.gets.chomp

      next unless confirmation == "yes" or confirmation == ""

      matching_snippets.all.each do |snippet|
        puts "Replacing text in #{snippet.document.name} on #{snippet.webpage.url}"
        snippet.document.body.gsub! find, replace
        snippet.document.save
      end

      matching_posts.all.each do |post|
        puts "Replacing text in '#{post.title}'"
        post.body.gsub! find, replace
        post.save
      end

    end

    desc 'Remove orphaned snippets'
    task :deorphan => :environment do
      puts "Orphaned Snippet removal begun.."

      orphaned_snippets = Snippet.where([
          "user_id NOT IN (?) OR document_id NOT IN (?) OR webpage_id NOT IN (?)",
          User.select("id"),
          Document.select("id"),
          Webpage.select("id")
      ])

      orphaned_snippets.each do |orphaned_snippet|
        orphaned_snippet.document.destroy
        orphaned_snippet.destroy
        puts "Destroyed orphaned snippet: '#{orphaned_snippet.document.name}' with ID: '#{orphaned_snippet.id}'"
      end
    end

    desc 'Removed unused snippets'
    task :simplify => :environment do
      puts "Unused Snippet removal begun.."

      Webpage.all.each do |webpage|
        # Download the template...
        puts "Fetching template for #{webpage.url}"

        begin
          template = Nokogiri::HTML open(webpage.url)
          template_snippets = template.xpath("//snippet").map {|element| element['id']}

          # Find all snippets for this webpage that aren't in the array above and delete them
          unused_snippets = Snippet.joins(:document).where([
            "webpage_id = (?) AND documents.name NOT IN (?)",
            webpage.id,
            template_snippets
          ]).order(created_at: :desc)

          unused_snippets.each do |unused_snippet|
            unused_snippet.document.destroy
            unused_snippet.destroy
            puts "Destroyed unused snippet: '#{unused_snippet.document.name}' with ID: '#{unused_snippet.id}'"
          end
        rescue Exception => e
          puts "Error processing unused snippet removal for Webpage.\nError message: #{e.message}\nTrace: #{e.backtrace.inspect}"
        end
      end
    end

    desc 'Remove duplicate snippets'
    task :dedupe => :environment do
      puts "Snippet de-duplication begun.."

      Webpage.all.each do |webpage|
        puts "De-duplicating Snippets for Webpage: #{webpage.url}"

        snippets = webpage.snippets
        snippets_deduped = snippets.to_a.uniq { |snippet| snippet.document.name } # Use natural sort order to de-dupe Snippets
        leaked_snippets = snippets - snippets_deduped # Take difference of Snippets minus 'Actual Snippets'

        leaked_snippets.each do |leaked_snippet|
          leaked_snippet.document.destroy
          leaked_snippet.destroy
          puts "Destroyed leaked duplicate snippet: '#{leaked_snippet.document.name}' with ID: '#{leaked_snippet.id}'"
        end
      end
    end

    desc 'Remove leaked data by deleting duplicates and orphans'
    task :unleak => :environment do
      # First, remove all orphaned snippets, where orphaning can occur on user, document or webpage
      Rake::Task['cortex:snippets:deorphan'].execute
      Rake::Task['cortex:snippets:simplify'].execute
      Rake::Task['cortex:snippets:dedupe'].execute
    end

    namespace :media do
      desc 'Update media URLs in snippets'
      task :update_urls => do
        old_url = ENV['OLD_PATH']
        new_url = ENV['NEW_PATH']
        tenant = ENV['TENANT']

        if [old_url, new_url, tenant].include? nil
          puts 'You must add OLD_PATH, NEW_PATH and TENANT as env vars before continuing'
          next
        end

        Media.all.each do |media|
          old_url = media.attachment.arbitrary_url_for old_url
          new_url = media.attachment.arbitrary_url_for new_url

          puts "About to update all occurences of #{old_url} to #{new_url} in tenant #{tenant}..."
          system("FIND=#{old_url} REPLACE=#{new_url} TENANT=#{tenant} rake cortex:snippets:replace")
        end
      end
    end
  end

  namespace :onet do
    desc 'Download ONET database'
    task :fetch => :environment do
      fetch_onet_db
    end

    desc 'Provision ONET database'
    task :provision => :environment do
      provision_onet_db
    end

    desc 'Download and provision ONET database'
    task :fetch_and_provision => :environment do
      fetch_onet_db
      provision_onet_db
    end
  end
end

private

def fetch_onet_db
  puts "Downloading ONET db: #{onet_package_name}.."

  Net::HTTP.start('www.onetcenter.org') do |http|
    resp = http.get("/dl_files/#{onet_package_name}.zip")
    open(Rails.root.join('tmp', "#{onet_package_name}.zip"), 'wb') { |file| file.write(resp.body) }

    sh "unzip -o #{Rails.root.join('tmp', "#{onet_package_name}.zip")} -d #{Rails.root.join('tmp')}"
  end
end

def provision_onet_db
  seed_industries
  provision_onet_occupations
end

def provision_onet_occupations
  puts 'Provisioning ONET Occupations..'

  first = true
  CSV.foreach(Rails.root.join('tmp', onet_package_name, 'Occupation Data.txt'), :headers => %w(soc title description), :col_sep => "\t") do |row|
    if first
      # Absolutely gross, CSV's foreach doesn't give us a counter, and no way to skip the first row when defining your own headers, so...
      first = false
      next
    end

    Onet::Occupation.create!(row.to_hash)
  end
end

def seed_industries
  puts 'Seeding Industries (Job Families)..'
  industries_seed = SeedData.onet_industries

  industries_seed.each do |industry|
    unless Onet::Occupation.find_by soc: industry[:soc]
      Onet::Occupation.create!(industry)
    end
  end
end

def onet_package_name
  "db_#{(Cortex.config.onet.version.to_s || '18.1').gsub('.', '_')}"
end
