class Promo < Post
  index_name [Rails.env, 'posts'].join('_')
  document_type    'posts'
  store_accessor :meta, :destination_url, :call_to_action

  # TODO: Figure out a way to get this properly abstracted
  enum display: [:large, :medium, :small]

  validates :destination_url, :call_to_action, presence: true, allow_nil: false

end