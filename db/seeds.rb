SEED_DATA = YAML.load_file("#{Rails.root}/db/seeds.yml")[Rails.env]

database = Apartment::Database.current

SEED_DATA['organizations'].each do |organization|
end

=begin
database = Apartment::Database.current

# Development seed data
if Rails.env.development?

  if database == 'development'
    # Create development organizations
    if !Organization.exists?(:name => 'acme')
      Organization.create(name: 'acme', display_name: 'Acme Corporation')
      Organization.create(name: 'ajax', display_name: 'Ajax Corporation')
    end
  elsif ['acme', 'ajax'].include? database
    # Create development users
    User.create(username: 'George', password:'welcome1')
    User.create(username: 'Bethanne', password:'welcome1')
  end

end

# Universal seed data
if ['development', 'test', 'production'].include? database
  if !User.exists?(:username => 'surgeon')
    User.create(username: 'surgeon', password: 'welcome1')
  end
end
=end