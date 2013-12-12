class CreateOrganization
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(tenant_id)
    database_name = Tenant.find(tenant_id).subdomain
    Apartment::Database.create(database_name)
    Apartment::Database.switch(database_name)
    Apartment::Database.seed
  end
end