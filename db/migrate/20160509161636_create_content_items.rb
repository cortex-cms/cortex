class CreateContentItems < ActiveRecord::Migration
  def change
    create_table :content_items do |t|
      t.string :publish_state
      t.datetime :published_at
      t.datetime :expired_at
      t.integer :author_id
      t.integer :creator_id
      t.references :content_type

      t.timestamps null: false
    end
  end
end
