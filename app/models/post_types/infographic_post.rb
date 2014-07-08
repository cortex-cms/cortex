class InfographicPost < Post
  index_name     [Rails.env, 'posts'].join('_')
  document_type  'posts'

  # TODO: Figure out a way to get this properly abstracted
  enum display: [:large, :medium, :small]
end
