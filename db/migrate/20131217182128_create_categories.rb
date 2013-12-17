class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :user_id, null: false, index: true
      t.integer :parent_id, index: true
      t.integer :lft, index: true
      t.integer :rgt, index: true
      t.integer :depth, index: true

      t.timestamps
    end
  end
end
