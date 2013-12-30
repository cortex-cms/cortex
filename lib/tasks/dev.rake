namespace :dev do

  desc 'Create, migrate and seed, including apartment'
  task :bootstrap => :environment do
    Rake::Task['db:create'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
    Rake::Task['apartment:create'].execute
    Rake::Task['apartment:migrate'].execute
    Rake::Task['apartment:seed'].execute
  end

  desc 'Start foreman with the development environment'
  task :foreman do
    exec('foreman start -e development.env')
  end
end