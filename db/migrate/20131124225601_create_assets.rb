class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :name, limit: 150
      t.integer :user_id, null: false
      t.datetime :deleted_at
      t.attachment :attachment

      t.timestamps
    end
    add_index :assets, :user_id
  end
end
