class AddAuthorRelationToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :author_id, :integer
    execute 'INSERT INTO authors (name) SELECT DISTINCT author FROM posts'
    execute 'UPDATE posts SET author_id=a.id FROM posts p, authors a WHERE p.author=a.name'
    change_column :posts, :author_id, :integer, null: false
    remove_column :posts, :author
    add_index :posts, :author_id
  end

  def down
    add_column :posts, :author, :string
    execute 'UPDATE posts SET author=authors.name FROM posts p, authors a WHERE p.author_id=a.id'
    remove_column :posts, :author_id
    remove_index :posts, :author_id
  end
end
