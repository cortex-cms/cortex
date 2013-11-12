json.array!(@platform_admins) do |platform_admin|
  json.extract! platform_admin, :user_id, :organization_id
  json.url platform_admin_url(platform_admin, format: :json)
end
