json.extract! asset, :name
json.extract! asset, :id
json.url asset_url(asset, format: :json)
json.attachment_url asset.attachment.url
json.attachment_thumb_url asset.attachment.url(:thumb)
json.extract! asset, :dimensions
json.creator do
  json.user_id asset.user.id
  json.name asset.user.name
end
json.extract! asset, :tags
json.extract! asset, :description
json.file_name asset.attachment_file_name
json.file_size asset.attachment_file_size
json.content_type asset.attachment_content_type
json.extract! asset, :created_at
json.extract! asset, :updated_at
json.extract! asset, :deactive_at
