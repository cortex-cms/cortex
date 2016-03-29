class Youtube < Media
  # index_name       'media'
  index_name [Rails.env, 'media'].join('_')
  document_type    'media'
  taxon_class_name 'media'

  store_accessor :meta, :url, :duration, :video_id, :title, :authors, :channel_id, :source_published_at, :video_description, :channel_title

  validates :video_id, presence: true

  def content_type
    'youtube'
  end

  def skip_attachment_validation
    true
  end

  def taxon_type
    'VID'
  end
end
