module YoutubeHelper
  def self.fetch_info(video_id)
    video = Yt::Video.new id:  video_id

    info = {}
    info[:url]                 = "https://www.youtube.com/v/#{video_id}"
    info[:thumbnail]           = video.thumbnail_url
    info[:title]               = video.title
    info[:channel_id]          = video.channel_id
    info[:channel_title]       = video.channel_title
    info[:authors]             = [info[:channel_title]]
    info[:duration]            = video.duration
    info[:description]         = video.description
    info[:source_published_at] = DateTime.parse(video.published_at.to_s)

    info
  end
end
