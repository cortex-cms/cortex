class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :name
      t.string  :resource_type
      t.integer :resource_id

      t.timestamps null: false
    end
  end
end
