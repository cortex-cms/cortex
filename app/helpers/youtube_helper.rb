module YoutubeHelper
  def self.fetch_info(video_id)
    video = Yt::Video.new id:  video_id

    info = {}
    info[:url] = "https://www.youtube.com/v/#{video_id}"
    info[:thumbnail]           = video.thumbnail_url
    info[:title]               = video.title
    info[:authors]             = video.channel_name
    info[:channel_id]          = video.channel_id
    info[:duration]            = video.duration
    info[:description]         = video.description
    info[:source_published_at] = DateTime.parse(video.published_at)
    info[:source_updated_at]   = info[:source_published_at]

    info
  end
end
