class AddSlugToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :slug, :string
    execute "UPDATE posts SET slug=lower(concat(replace(title, ' ', '-'), '-', id))"
    change_column :posts, :slug, :string, :null => false
    add_index :posts, :slug, :unique => true
  end

  def down
    remove_index :posts, :slug
    remove_column :posts, :slug
  end
end
