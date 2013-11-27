json.extract! tenant, :name, :id, :contact_name, :contact_email, :contact_phone, :created_at, :deleted_at, :updated_at, :contract, :did
json.url tenant_url(tenant, format: :json)
json.parent_url tenant.parent_id ? tenant_url(tenant.parent_id, format: :json) : nil
json.parent_id tenant.parent_id
json.organization_url organization_url(tenant.organization_id, format: :json)
json.organization_id tenant.organization_id
