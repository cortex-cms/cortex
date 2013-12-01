SEED_DATA = YAML.load_file("#{Rails.root}/db/seeds.yml")[Rails.env]

def create_tenant_tree(tenant, parent=nil)
  t = Tenant.find_by name: tenant['name']
  if !t
    puts "  Creating tenant '#{tenant['name']}'"
    t = Tenant.create(name: tenant['name'],
                      contact_name: tenant['contact_name'],
                      contact_phone: tenant['contact_phone'],
                      contact_email: tenant['contact_email'],
                      contract: tenant['contract'],
                      did: tenant['did'],
                      subdomain: tenant['subdomain'])
  else
    puts "  Skipping existing tenant #{tenant['name']}"
  end

  t.move_to_child_of(parent) if parent
  tenant['children'].each do |child|
    create_tenant_tree(child, t)
  end
end

if data = SEED_DATA['databases'][Apartment::Database.current]
  # seed users
  data['users'].each do |u|
    if !User.exists?(:name => u['name'])
      User.create(name: u['name'], password: u['password'], email: u['email'])
    end
  end

  # seed tenants
  if data['tenants']
    data['tenants'].each do |t|
      create_tenant_tree(t)
    end
  end
end