class Youtube < Media
  index_name       'media'
  document_type    'media'
  taxon_class_name 'media'

  after_create :fetch_youtube
  store_accessor :meta, :url, :duration, :video_id, :title, :authors, :source_published_at,
                 :source_updated_at, :video_description

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

  private

  def fetch_youtube
    YoutubeMediaWorker.perform_async(id)
  end
end
