class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :name
      t.integer :user_id
      t.datetime :deleted_at
      t.attachment :attachment

      t.timestamps
    end
  end
end
