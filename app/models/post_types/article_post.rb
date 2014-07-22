class ArticlePost < Post
  index_name     [Rails.env, 'posts'].join('_')
  document_type  'post'

  # TODO: Figure out a way to get this properly abstracted
  enum display: [:large, :medium, :small]
end
