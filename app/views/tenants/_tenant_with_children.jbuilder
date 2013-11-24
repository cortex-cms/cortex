json.partial! tenant
json.children tenant.children do |child|
  json.partial! 'tenants/tenant_with_children', tenant: child
end