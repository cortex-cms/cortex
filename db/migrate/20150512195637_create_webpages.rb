class CreateWebpages < ActiveRecord::Migration
  def change
    create_table :webpages do |t|
      t.integer :user_id, null: false, index: true
      t.string :name
      t.string :url
      t.attachment :thumbnail
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end
