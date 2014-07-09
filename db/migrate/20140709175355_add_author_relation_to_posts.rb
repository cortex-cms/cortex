class AddAuthorRelationToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :author_id, :integer, null: false
    add_index :posts, :author_id

    execute 'INSERT INTO authors (name) SELECT DISTINCT author FROM posts'
    remove_column :posts, :author
  end

  def down
    add_column :posts, :author, :string
    execute 'UPDATE p SET p.author=a.name FROM posts p JOIN authors a ON a.id=p.author_id'
    remove_column :posts, :author_id
    remove_index :posts, :author_id
  end
end
