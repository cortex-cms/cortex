class ConvertFieldTypeIdsToGuids < ActiveRecord::Migration[5.0]
  def change
    drop_table :field_types

    create_table :field_types, id: false do |t|
      t.uuid :id, primary_key: true, default: 'uuid_generate_v4()'

      t.timestamps null: false
    end
  end
end
