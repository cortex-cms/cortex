SEED_DATA = YAML.load_file("#{Rails.root}/db/seeds.yml")[Rails.env]

def create_tenant_tree(tenant, organization, parent=nil)
  t = organization.tenants.find_by name: tenant['name']
  if !t
    puts "  Creating tenant '#{tenant['name']}'"
    t = organization.tenants.create(name: tenant['name'],
                                    contact_name: tenant['contact_name'],
                                    contact_phone: tenant['contact_phone'],
                                    contact_email: tenant['contact_email'],
                                    contract: tenant['contract'],
                                    did: tenant['did'])
  else
    puts "  Skipping existing tenant #{tenant['name']}"
  end

  t.move_to_child_of(parent) if parent
  tenant['children'].each do |child|
    create_tenant_tree(child, organization, t)
  end
end

if data = SEED_DATA['databases'][Apartment::Database.current]
  # seed users
  data['users'].each do |u|
    if !User.exists?(:name => u['name'])
      User.create(name: u['name'], password: u['password'])
    end
  end

  # seed organizations
  data['organizations'].each do |o|
    organization = Organization.find_by_name o['name']
    if !organization
      puts "Creating organization #{o['display_name']}"
      organization = Organization.create(name: o['name'], display_name: o['display_name'])
    else
      puts "Skipping existing organization #{o['display_name']}"
    end
    # create tenants
    puts "Creating tenants for #{o['display_name']}..."
    o['tenants'].each do |t|
      create_tenant_tree(t, organization)
    end
  end
end