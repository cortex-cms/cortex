class CreateOrganization
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(tenant_id)
    database_name = Tenant.find(tenant_id).database_name
    Apartment::Database.create(database_name)
    Apartment::Migrator.migrate(database_name)
    Apartment::Database.seed(database_name)
  end
end