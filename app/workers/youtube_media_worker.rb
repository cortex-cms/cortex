require 'json'

class YoutubeMediaWorker
  include Sidekiq::Worker

  def perform(media_id)
    media = Media.find(media_id)

    # This process uses the deprecated YouTube Data API v2.
    # The v2 API is not guaranteed to function after April 20th, 2015
    # TODO: Switch to v3: https://developers.google.com/youtube/v3/docs/videos/list
    r = Excon.get("https://gdata.youtube.com/feeds/api/videos/#{media.video_id}?v=2&alt=json")

    if r.status >= 300; raise "Error while requesting Youtube data (#{r.status}) r.body" end

    data                = JSON.parse(r.body)
    youtube_thumbnail   = "https://i1.ytimg.com/vi/#{media.video_id}/maxresdefault.jpg"
    youtube_url         = "https://www.youtube.com/v/#{media.video_id}"
    youtube_title       = data['entry']['title']['$t']
    youtube_authors     = data['entry']['author'].collect{ |a| a['name']['$t'] }
    youtube_duration    = data['entry']['media$group']['yt$duration']['seconds']
    youtube_description = data['entry']['media$group']['media$description']['$t']
    youtube_published   = DateTime.parse(data['entry']['published']['$t'])
    youtube_updated     = DateTime.parse(data['entry']['updated']['$t'])

    media.url                 = youtube_url
    media.title               = youtube_title
    media.authors             = youtube_authors
    media.duration            = youtube_duration
    media.source_published_at = youtube_published
    media.source_updated_at   = youtube_updated
    media.video_description   = youtube_description

    # Fetch thumbnail
    r = Excon.get(youtube_thumbnail)

    if r.status >= 300; raise "Error while requesting Youtube thumbnail (#{r.status}) r.body" end

    tmp = Tempfile.new([media.video_id, '.jpg'], Dir.tmpdir, 'wb+')
    tmp.binmode
    tmp.write(r.body)
    tmp.rewind
    media.attachment = tmp
    tmp.close

    media.save!

    true
  end
end
