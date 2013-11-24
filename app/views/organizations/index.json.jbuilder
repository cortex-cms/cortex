json.array!(@organizations) do |organization|
  json.extract! organization, :name, :id, :display_name
  json.url organization_url(organization, format: :json)
end
