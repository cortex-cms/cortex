module YoutubeHelper
  def self.fetch_info(video_id)
    video = {}
    video[:url] = "https://www.youtube.com/v/#{video_id}"
    r = Excon.get("http://www.youtube.com/oembed?url=#{video[:url]}&format=json")

    raise "Error while requesting Youtube data\nStatus: #{r.status}\nBody: #{r.body}" if r.status >= 300

    data                        = JSON.parse(r.body)
    video[:thumbnail]           = data["thumbnail_url"]
    video[:title]               = data["title"]
    video[:authors]             = data["author_name"]

    ## The metadata for these fields ^^ is only accessible from the oembed JSON request
    ## The metadata for these fields \/ is only accessible from the v3 API

    video = Yt::Video.new id:  video_id

    video[:duration]            = video.duration
    video[:description]         = video.description
    video[:source_published_at] = DateTime.parse(video.published_at)
    video[:source_updated_at]   = video[:source_published_at]

    video
  end
end
