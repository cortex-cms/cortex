class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :name
      t.belongs_to :user, index: true
      t.string :filename
      t.datetime :archived_at
      t.datetime :active_at
      t.datetime :deactive_at
      t.attachment :file
      t.text :description
      t.boolean :published

      t.timestamps
    end
  end
end
