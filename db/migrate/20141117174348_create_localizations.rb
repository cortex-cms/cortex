class CreateLocalizations < ActiveRecord::Migration
  def change
    create_table :localizations, id: false do |t|
      t.uuid :id, primary_key: true, default: 'uuid_generate_v4()'
      t.integer :jargon_id, null: false
      t.belongs_to :user
    end

    add_index :localizations, :id
    add_index :localizations, :jargon_id
    add_index :localizations, :user_id
  end
end
