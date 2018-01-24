# Create root tenant and user
cortex_tenant_seed = Cortex.seed_data[:cortex_tenant]
example_tenant_seed = Cortex.seed_data[:example_tenant]
example_subtenant_seed = Cortex.seed_data[:example_subtenant]
example_contract_seed = Cortex.seed_data[:example_contract]
user_seed = cortex_tenant_seed[:creator]

existing_tenant = Cortex::Tenant.find_by_name(cortex_tenant_seed[:name])

unless existing_tenant
  user = Cortex::User.new(email: user_seed[:email],
                  firstname: user_seed[:firstname],
                  lastname: user_seed[:lastname],
                  password: user_seed[:password],
                  password_confirmation: user_seed[:password])
  cortex_tenant = Cortex::Tenant.new(name: cortex_tenant_seed[:name],
                             name_id: cortex_tenant_seed[:name_id],
                             description: cortex_tenant_seed[:description],
                             owner: user)
  example_tenant = Cortex::Tenant.new(name: example_tenant_seed[:name],
                              name_id: example_tenant_seed[:name_id],
                              description: example_tenant_seed[:description],
                              owner: user)
  example_subtenant = Cortex::Tenant.new(name: example_subtenant_seed[:name],
                                 name_id: example_subtenant_seed[:name_id],
                                 description: example_subtenant_seed[:description],
                                 owner: user,
                                 parent: example_tenant)
  example_contract = Cortex::Contract.new(name: example_contract_seed[:name],
                                  tenant: cortex_tenant)

  cortex_tenant.save!
  example_tenant.save!
  example_subtenant.save!

  example_contract.save!

  user.tenants = [cortex_tenant, example_tenant]
  user.save!
end
