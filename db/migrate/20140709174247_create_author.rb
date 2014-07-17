class CreateAuthor < ActiveRecord::Migration
  def up

    rename_column :posts, :author, :custom_author

    create_table :authors do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.hstore :sites # personal, facebook, twitter, G+, etc.
      t.string :title
      t.text :bio
      t.belongs_to :user
    end
    add_index :authors, :user_id

    execute 'INSERT INTO authors (firstname, lastname, email, user_id) SELECT firstname, lastname, email, id FROM users'
  end

  def down
    drop_table :authors
    rename_column :posts, :custom_author, :author
  end
end
