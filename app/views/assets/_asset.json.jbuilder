json.extract! asset, :name
json.url asset_url(asset, format: :json)
json.attachment_url asset.attachment.url
json.attachment_thumb_url asset.attachment.url(:thumb)
json.creator do
  json.user_id asset.user.id
  json.name asset.user.name
end
json.file_name asset.attachment_file_name
json.file_size asset.attachment_file_size
json.content_type asset.attachment_content_type
json.created_at asset.created_at
json.updated_at asset.updated_at
json.description asset.description
json.deactive_at asset.deactive_at
json.tags asset.tags
