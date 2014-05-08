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
end
