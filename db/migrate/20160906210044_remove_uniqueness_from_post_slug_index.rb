class RemoveUniquenessFromPostSlugIndex < ActiveRecord::Migration
  def change
    remove_index :posts, :slug
    add_index :posts, :slug
  end
end
