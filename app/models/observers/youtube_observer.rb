class YoutubeObserver < ActiveRecord::Observer
  def after_create(media)
    fetch_youtube(media)
  end

  private

  def fetch_youtube
    YoutubeMediaWorker.perform_async(id)
  end
end
