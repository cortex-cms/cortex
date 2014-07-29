require 'rake'
require 'net/http'
require 'csv'

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
    [Post, Media, Onet::Occupation].each do |klass|
      klass.__elasticsearch__.create_index! force: true
      klass.import
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
  "db_#{(Cortex.config.onet.version || '18.1').gsub('.', '_')}"
end
