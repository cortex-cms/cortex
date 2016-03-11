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
    [Post, Media, Onet::Occupation, Webpage].each do |klass|
      klass.__elasticsearch__.create_index! force: true
      klass.import
    end
  end

  desc 'Remove orphaned snippets'
  task :deorphan => :environment do
    Snippet.where([
        "user_id NOT IN (?) OR document_id NOT IN (?) OR webpage_id NOT IN (?)",
        User.select("id"),
        Document.select("id"),
        Webpage.select("id")
    ]).destroy_all
  end

  desc 'Removed unused snippets'
  task :simplify => :environment do
    # Now, loop through all the webpages...
    Webpage.all.each do |webpage|
      # Download the template...
      puts "Fetching template for #{webpage.url}"
      begin
        template = Nokogiri::HTML open(webpage.url)
        template_snippets = template.xpath("//snippet").map {|element| element['id']}

        # Find all snippets for this webpage that aren't in the array above and delete them
        Snippet.joins(:document).where([
          "webpage_id = (?) AND documents.name NOT IN (?)",
          webpage.id,
          template_snippets
        ]).order(created_at: :desc).destroy_all
      rescue
      end
    end
  end

  desc 'Remove duplicate snippets'
  task :dedupe => :environment do
    # Then, check for duplicates on the name field, sort according to the API and delete all but the first ones
    grouped = Snippet.joins(:document).all.group_by{|model| [model.document.name, model.webpage_id] }

    grouped.values.each do |duplicates|
      # the first one we want to keep right?
      first_one = duplicates.shift # or pop for last one
      # if there are any more left, they are duplicates
      # so delete all of them
      duplicates.each{|double| double.destroy} # duplicates can now be destroyed
    end
  end

  desc 'Remove leaked data by deleting duplicates and orphans'
  task :unleak => :environment do
    # First, remove all orphaned snippets, where orphaning can occur on user, document or webpage
    Rake::Task['cortex:deorphan'].execute
    Rake::Task['cortex:simplify'].execute
    Rake::Task['cortex:dedupe'].execute
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
