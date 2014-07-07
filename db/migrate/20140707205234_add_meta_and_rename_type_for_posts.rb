class AddMetaAndRenameTypeForPosts < ActiveRecord::Migration
  def up
    add_column :posts, :meta, :hstore
    add_column :posts, :post_type, :string, default: 'Post', null: false
  end

  def down
    remove_column :posts, :post_type
    remove_column :posts, :meta
  end
end
