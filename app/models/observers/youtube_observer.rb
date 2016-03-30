class YoutubeObserver < ActiveRecord::Observer
  def after_create(media)
    YoutubeMediaJob.perform_later(media)
  end
end
