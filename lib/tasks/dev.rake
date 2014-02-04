namespace :dev do
  desc 'Start foreman with the development environment'
  task :foreman do
    exec('foreman start -e development.env')
  end
end
