class YoutubeMediaJob < ActiveJob::Base
  queue_as :default

  def perform(media_id)
    media = Media.find(media_id)

    info = YoutubeHelper::fetch_info(media.video_id)

    media.url                 = info[:url]
    media.title               = info[:title]
    media.authors             = info[:authors]
    media.duration            = info[:duration]
    media.channel_id          = info[:channel_id]
    media.channel_title       = info[:channel_title]
    media.source_published_at = info[:published]
    media.video_description   = info[:description]

    # Fetch thumbnail
    r = Excon.get(info[:thumbnail])

    raise "Error while requesting Youtube thumbnail\nStatus: #{r.status}\nBody: #{r.body}" if r.status >= 300

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
