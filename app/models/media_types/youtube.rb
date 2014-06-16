class Youtube < Media
  after_create :fetch_youtube
  store_accessor :meta, :url, :duration, :video_id, :title, :author, :duration,
                 :source_published_at, :source_updated_at

  validates :video_id, presence: true

  def content_type
    'youtube'
  end

  def url
    meta.url
  end

  def skip_attachment_validation
    true
  end

  private

  def fetch_youtube
    YoutubeMediaWorker.perform_async(id)
  end
end
