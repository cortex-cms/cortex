class CreateLocales < ActiveRecord::Migration
  def change
    create_table :locales, id: false do |t|
      t.uuid :id, primary_key: true, default: 'uuid_generate_v4()'
      t.string :jargon_id, null: false
      t.belongs_to :user
    end

    add_index :locales, :id
    add_index :locales, :jargon_id
    add_index :locales, :user_id
  end
end
