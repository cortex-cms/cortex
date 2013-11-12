json.array!(@tenants) do |tenant|
  json.extract! tenant, :name, :parent_id, :lft, :rgt, :depth, :contact_name, :contact_email, :contact_phone, :active_at, :inactive_at, :contract, :did
  json.url tenant_url(tenant, format: :json)
end
