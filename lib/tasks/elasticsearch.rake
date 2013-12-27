namespace :elasticsearch do
  desc 'Deletes all ElasticSearch indexes'
  task :drop do
    Tire.index('assets').delete
  end
end