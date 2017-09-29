class CreateFields < ActiveRecord::Migration[5.1]
  def change
    create_table :fields, id: :uuid do |t|
      t.references :content_type, type: :uuid, null: false, foreign_key: true
      t.string :field_type, null: false, index: true
      t.string :name, :string, index: true
      t.jsonb :metadata, null: false, default: {}
      t.jsonb :validations, null: false, default: {}

      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end
  end
end
