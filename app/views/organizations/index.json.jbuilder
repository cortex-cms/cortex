json.array!(@organizations) do |organization|
  json.extract! organization, :name, :id
  json.url organization_url(organization, format: :json)
end
