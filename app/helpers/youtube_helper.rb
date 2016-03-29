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
    video[:duration]            = data['entry']['media$group']['yt$duration']['seconds']
    video[:description]         = data['entry']['media$group']['media$description']['$t']
    video[:source_published_at] = DateTime.parse(data['entry']['published']['$t'])
    video[:source_updated_at]   = DateTime.parse(data['entry']['updated']['$t'])

    video
  end
end
