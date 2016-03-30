class YoutubeObserver < ActiveRecord::Observer
  def after_create(media)
    # Delay job by 5 seconds, as there appears to be a bug somewhere as it relates to STI+Observers+ActiveJob.
    # The Media object mysteriously will not exist after_create..
    # TODO: Remove this workaround.
    YoutubeMediaJob.set(wait: 5.seconds).perform_later(media)
  end
end
