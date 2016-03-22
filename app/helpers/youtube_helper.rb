require 'json'

module YoutubeHelper
  def self.fetch_info(video_id)
    video = {}
    # This process uses the deprecated YouTube Data API v2.
    # The v2 API is not guaranteed to function after April 20th, 2015
    # TODO: Switch to v3: https://developers.google.com/youtube/v3/docs/videos/list
    r = Excon.get("https://gdata.youtube.com/feeds/api/videos/#{video_id}?v=2&alt=json")

    raise "Error while requesting Youtube data\nStatus: #{r.status}\nBody: #{r.body}" if r.status >= 300

    data                        = JSON.parse(r.body)
    video[:url]                 = "https://www.youtube.com/v/#{video_id}"
    video[:thumbnail]           = "https://i1.ytimg.com/vi/#{video_id}/hqdefault.jpg"
    video[:title]               = data['entry']['title']['$t']
    video[:authors]             = data['entry']['author'].collect{ |a| a['name']['$t'] }
    video[:duration]            = data['entry']['media$group']['yt$duration']['seconds']
    video[:description]         = data['entry']['media$group']['media$description']['$t']
    video[:source_published_at] = DateTime.parse(data['entry']['published']['$t'])
    video[:source_updated_at]   = DateTime.parse(data['entry']['updated']['$t'])

    video
  end
end
