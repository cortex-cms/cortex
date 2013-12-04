json.extract! tenant, :name, :id, :contact_name, :contact_email, :contact_phone, :created_at, :deleted_at, :deactive_at, :active_at, :updated_at, :contract, :did
json.url tenant_url(tenant, format: :json)
json.parent_url tenant.parent_id ? tenant_url(tenant.parent_id, format: :json) : nil
json.parent_id tenant.parent_id
if not tenant.root?
  json.organization_url tenant_url(tenant.root, format: :json)
  json.organization_id = tenant.root.id
end
