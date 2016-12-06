class YoutubeObserver < ActiveRecord::Observer
  def after_commit(media)
    YoutubeMediaJob.perform_later(media)
  end
end
