class CreateFields < ActiveRecord::Migration[5.1]
  def change
    create_table :fields, id: :uuid do |t|
      t.references :content_type, type: :uuid, null: false, foreign_key: true
      t.string :field_type, null: false, index: true
      t.integer :order
      t.boolean :required, null: false, default: false

      t.timestamps null: false
    end
  end
end
