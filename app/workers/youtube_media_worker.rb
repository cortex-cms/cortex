class YoutubeMediaWorker
  include Sidekiq::Worker

  def perform(media_id)
    media = Media.find(media_id)

    info = YoutubeHelper::fetch_info(media.video_id)

    media.url                 = info[:url]
    media.title               = info[:title]
    media.authors             = info[:authors]
    media.duration            = info[:duration]
    media.source_published_at = info[:published]
    media.source_updated_at   = info[:updated]
    media.video_description   = info[:description]

    # Fetch thumbnail
    r = Excon.get(info[:thumbnail])

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
