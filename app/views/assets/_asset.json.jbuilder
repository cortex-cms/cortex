json.extract! asset, :name
json.url asset_url(asset, format: :json)
json.creator do
  json.user_id asset.user.id
  json.name asset.user.name
end
json.file_name asset.attachment_file_name
json.file_size asset.attachment_file_size
json.content_type asset.attachment_content_type
json.updated_at asset.attachment_updated_at