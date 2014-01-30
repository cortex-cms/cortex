json.extract! post, :id, :title, :type, :published_at, :expired_at, :deleted_at, :created_at, :updated_at, :draft, :comment_count, :body, :short_description, :job_phase, :display, :featured_image_url, :notes, :copyright_owner, :seo_tilte, :seo_description, :seo_preview, :type
json.url post_url(post, format: :json)
json.tags post.tag_list
json.categories post.categories do |c|
  json.name c.name
  json.id c.id
  json.url category_url(c, format: :json)
end
json.author do
  json.id post.user.id
  json.name post.user.name
  json.url user_url(post.user, format: :json)
end