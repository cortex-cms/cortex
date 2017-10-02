# Create root tenant and user
cortex_tenant_seed = SeedData.cortex_tenant
example_tenant_seed = SeedData.example_tenant
user_seed = cortex_tenant_seed.creator

existing_tenant = Tenant.find_by_name(cortex_tenant_seed.name)

unless existing_tenant
  user = User.new(email: user_seed.email,
                  firstname: user_seed.firstname,
                  lastname: user_seed.lastname,
                  password: user_seed.password,
                  password_confirmation: user_seed.password)
  cortex_tenant = Tenant.new(name: cortex_tenant_seed.name,
                             description: cortex_tenant_seed.description,
                             owner: user)
  example_tenant = Tenant.new(name: example_tenant_seed.name,
                              description: example_tenant_seed.description,
                              owner: user)

  cortex_tenant.save!
  example_tenant.save!

  user.tenants = [cortex_tenant, example_tenant]
  user.save!
end
