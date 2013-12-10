json.extract! asset, :name
json.url asset_url(asset, format: :json)
json.creator do
  json.user_id asset.user.id
  json.name asset.user.name
end
json.file_name asset.file_file_name
json.file_size asset.file_file_size
json.content_type asset.file_content_type
json.created_at asset.created_at
json.updated_at asset.updated_at
json.description asset.description
json.deactive_at asset.deactive_at