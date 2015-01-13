class YoutubeObserver < ActiveRecord::Observer
  def after_create(media)
    fetch_youtube(media)
  end

  private

  def fetch_youtube(media)
    YoutubeMediaJob.perform_later(media.id)
  end
end
