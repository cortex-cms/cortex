SEED_DATA = YAML.load_file("#{Rails.root}/db/seeds.yml")[Rails.env]

if data = SEED_DATA['databases'][Apartment::Database.current]

  # seed users
  data['users'].each do |u|
    if !User.exists?(:name => u['name'])
      User.create(name: u['name'], password: u['password'])
    end
  end

  # seed organizations
  data['organizations'].each do |o|
    if !Organization.exists?(:name => o['name'])
      Organization.create(name: o['name'], display_name: o['display_name'])
    end
  end

end