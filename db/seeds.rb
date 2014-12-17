# Create root tenant and user
tenant_seed   = SeedData.cortex_tenant
user_seed     = tenant_seed.creator

unless Tenant.find_by_name(tenant_seed.name)
  cortex_tenant = Tenant.new(name: tenant_seed.name)

  cortex_tenant.owner   = User.new(email: user_seed.email,
                           firstname: user_seed.firstname,
                           lastname: user_seed.lastname,
                           password: user_seed.password,
                           password_confirmation: user_seed.password,
                           tenant: cortex_tenant,
                           admin: true)

  cortex_tenant.save!
end
