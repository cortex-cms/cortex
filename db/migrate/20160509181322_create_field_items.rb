class CreateFieldItems < ActiveRecord::Migration[5.1]
  def change
    create_table :field_items, id: :uuid do |t|
      t.text :text
      t.references :field, type: :uuid, foreign_key: true
      t.references :content_item, type: :uuid, foreign_key: true

      t.timestamps null: false
    end
  end
end
