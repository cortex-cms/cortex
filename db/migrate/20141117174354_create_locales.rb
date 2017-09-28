class CreateLocales < ActiveRecord::Migration[5.1]
  def change
    create_table :locales, id: false do |t|
      t.uuid :id, primary_key: true, default: 'uuid_generate_v4()'
      t.string :name, null: false
      t.references :localization
      t.belongs_to :user

      t.timestamps
    end

    add_index :locales, :id
    add_index :locales, :localization_id
    add_index :locales, :user_id
  end
end
