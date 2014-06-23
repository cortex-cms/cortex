class AddTileMediaToPost < ActiveRecord::Migration
  def change
    add_column :posts, :tile_media_id, :integer, index: true
  end
end
