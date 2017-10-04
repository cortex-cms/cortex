class CreateFieldItems < ActiveRecord::Migration[5.1]
  def change
    create_table :field_items, id: :uuid do |t|
      t.jsonb :data, null: false, default: {}, index: { using: :gin }
      t.references :field, type: :uuid, null: false, foreign_key: true
      t.references :content_item, type: :uuid, null: false, foreign_key: true

      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end
  end
end
