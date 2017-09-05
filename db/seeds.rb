# Create root tenant and user
tenant_seed = SeedData.cortex_tenant
user_seed = tenant_seed.creator

existing_tenant = Tenant.find_by_name(tenant_seed.name)

unless existing_tenant
  cortex_tenant = Tenant.new(name: tenant_seed.name)

  cortex_tenant.owner = User.new(email: user_seed.email,
                                 firstname: user_seed.firstname,
                                 lastname: user_seed.lastname,
                                 password: user_seed.password,
                                 password_confirmation: user_seed.password,
                                 tenant: cortex_tenant,
                                 admin: true)

  cortex_tenant.save!
end

Tenant.create(parent_id: 1, name: "Marketing", subdomain: "marketing")
Tenant.create(parent_id: 1, name: "Sales team", subdomain: "salesteam")
Tenant.create(parent_id: 1, name: "Support", subdomain: "support")

umich = Tenant.new(name: "Umich", subdomain: "umich")
umich.save
Tenant.create(parent_id: umich.id, name: "Engineering", subdomain: "eng")
Tenant.create(parent_id: umich.id, name: "Booth Management", subdomain: "booth")
Tenant.create(parent_id: umich.id, name: "Art", subdomain: "art")

tbell = Tenant.new(name: "Taco Bell", subdomain: "tbell")
tbell.save
Tenant.create(parent_id: tbell.id, name: "Baja Balst", subdomain: "baja")
Tenant.create(parent_id: tbell.id, name: "Gordita Crunch", subdomain: "gordita")
Tenant.create(parent_id: tbell.id, name: "Chalupa Extreme", subdomain: "diabetes")
