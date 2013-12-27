namespace :elasticsearch do
  desc 'Deletes all ElasticSearch indexes'
  task :drop => [:environment] do
    Asset.tire.index.delete
  end
end