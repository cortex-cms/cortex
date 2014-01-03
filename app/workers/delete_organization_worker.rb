class DeleteOrganizationWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(tenant_id)
    database_name = Tenant.find(tenant_id).subdomain
    Apartment::Database.drop(database_name)
  end
end
