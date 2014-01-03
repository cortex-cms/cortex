json.extract! asset, :name, :id
json.url asset_url(asset, format: :json)
json.attachment_url asset.attachment.url
json.extract! asset, :dimensions
json.creator do
  json.id asset.user.id
  json.name asset.user.name
  json.url user_url(asset.user, format: :json)
end
json.thumbs do
  json.large asset.attachment.url(:large)
  json.normal asset.attachment.url(:thumb)
  json.mini asset.attachment.url(:mini)
  json.micro asset.attachment.url(:micro)
end
json.extract! asset, :tags, :description, :alt, :active
json.file_name asset.attachment_file_name
json.file_size asset.attachment_file_size
json.content_type asset.attachment_content_type
json.extract! asset, :created_at, :updated_at, :deactive_at, :deleted_at
