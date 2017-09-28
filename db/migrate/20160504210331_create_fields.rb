class CreateFields < ActiveRecord::Migration[5.1]
  def change
    create_table :fields do |t|
      t.references :content_type, null: false, index: true
      t.string :field_type, null: false
      t.integer :order
      t.boolean :required, null: false, default: false

      t.timestamps null: false
    end
  end
end
