class AddSeoFieldsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :noindex, :bool, default: false
    add_column :posts, :nofollow, :bool, default: false
    add_column :posts, :nosnippet, :bool, default: false
    add_column :posts, :noodp, :bool, default: false
    add_column :posts, :noarchive, :bool, default: false
    add_column :posts, :noimageindex, :bool, default: false
  end
end
