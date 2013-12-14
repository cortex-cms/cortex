namespace :dev do

  desc 'Delete all sqlite3 files in db/'
  task :drop do
    `rm db/*.sqlite3`
  end

  desc 'Create, migrate and seed, including apartment'
  task :bootstrap => :environment do
    Rake::Task['db:create'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
    Rake::Task['apartment:create'].execute
    Rake::Task['apartment:migrate'].execute
    Rake::Task['apartment:seed'].execute
  end
end