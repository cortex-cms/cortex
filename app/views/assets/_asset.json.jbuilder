json.url asset_url(asset, format: :json)
json.attachment_url asset.attachment.url
json.creator do
  json.id asset.user.id
  json.name asset.user.name
  json.url user_url(asset.user, format: :json)
end
json.thumbs do
  json.large asset.attachment.url(:large)
  json.default asset.attachment.url(:default)
  json.mini asset.attachment.url(:mini)
  json.micro asset.attachment.url(:micro)
end
json.file_name asset.attachment_file_name
json.file_size asset.attachment_file_size
json.has_thumbs asset.can_thumb
json.content_type asset.attachment_content_type
json.extract! asset, :name, :id, :created_at, :dimensions, :updated_at, :deactive_at, :deleted_at, :taxon, :general_type, :tags, :description, :alt, :active
