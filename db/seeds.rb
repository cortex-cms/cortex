seed = Hashr.new(YAML.load_file("#{Rails.root}/db/seeds.yml")[Rails.env])

# Create root tenant and user
tenant_seed   = seed.cortex_tenant
user_seed     = tenant_seed.creator

unless Tenant.find_by_name(tenant_seed.name)
  cortex_tenant = Tenant.new(name: tenant_seed.name)
  cortex_tenant.save!

  cortex_user   = User.new(name: user_seed.name,
                           password: user_seed.password,
                           password_confirmation: user_seed.password,
                           email: user_seed.email,
                           tenant_id: cortex_tenant.id)

  cortex_user.save!
  cortex_tenant.user = cortex_user
  cortex_tenant.save!
end

