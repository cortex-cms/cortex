class CreateJoinTablePostsAssets < ActiveRecord::Migration
  def change
    create_join_table :posts, :assets do |t|
      # t.index [:asset_id, :post_id]
      # t.index [:post_id, :asset_id]
    end
  end
end
