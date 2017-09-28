class CreateContentItems < ActiveRecord::Migration[5.1]
  def change
    create_table :content_items, id: :uuid do |t|
      t.string :publish_state
      t.datetime :published_at
      t.datetime :expired_at
      t.references :creator, type: :uuid, foreign_key: { to_table: :users }
      t.references :content_type, type: :uuid, foreign_key: true

      t.timestamps null: false
    end
  end
end
