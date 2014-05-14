class ChangeFeaturedImageUrlToFeaturedMedia < ActiveRecord::Migration
  def change
    remove_column :posts, :featured_image_url, :string
    add_column :posts, :featured_media_id, :integer, index: true
  end
end
