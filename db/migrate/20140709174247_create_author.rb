class CreateAuthor < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.string :email
      t.hstore :sites # personal, facebook, twitter, G+, etc.
      t.string :title
      t.text :bio
      t.belongs_to :user
    end
    add_index :authors, :user_id
  end
end
