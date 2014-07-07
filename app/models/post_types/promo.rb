class Promo < Post
  index_name [Rails.env, 'posts'].join('_')
  document_type    'posts'
  store_accessor :meta, :destination_url, :call_to_action

  validates :destination_url, :call_to_action, presence: true, allow_nil: false

end