json.url media_url(media, format: :json)
json.attachment_url media.attachment.url
json.creator do
  json.id media.user.id
  json.name media.user.name
  json.url user_url(media.user, format: :json)
end
json.thumbs do
  json.large media.attachment.url(:large)
  json.default media.attachment.url(:default)
  json.mini media.attachment.url(:mini)
  json.micro media.attachment.url(:micro)
end
json.file_name media.attachment_file_name
json.file_size media.attachment_file_size
json.has_thumbs media.can_thumb
json.content_type media.attachment_content_type
json.extract! media, :name, :id, :created_at, :dimensions, :updated_at, :deactive_at, :deleted_at, :taxon, :general_type, :tags, :description, :alt, :active
