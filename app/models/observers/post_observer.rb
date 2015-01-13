class PostObserver < ActiveRecord::Observer
  def before_save(post)
    update_media!(post)
  end

  private

  def update_media!(post)
    post.media = find_all_associated_media(post)
  end

  def find_all_associated_media(post)
    find_media_from_body(post).push(post.featured_media, post.tile_media).compact.uniq
  end

  def find_media_from_body(post)
    document = Nokogiri::HTML::Document.parse(post.body)
    media_ids = document.xpath('//@data-media-id').map{|element| element.to_s }
    Media.find(media_ids)
  end
end
