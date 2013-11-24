json.array!(@tenants) do |tenant|
  json.extract! tenant, :name, :contact_name, :contact_email, :contact_phone, :created_at, :deleted_at, :updated_at, :contract, :did
  json.url tenant_url(tenant, format: :json)
  json.parent_url tenant.parent_id ? tenant_url(tenant.parent_id, format: :json) : nil
end