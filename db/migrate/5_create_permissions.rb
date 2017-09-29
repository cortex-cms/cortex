class CreatePermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :permissions, id: :uuid do |t|
      t.string :name, index: true
      t.string :resource_type, index: true
      t.uuid :resource_id, index: true

      t.timestamps null: false
    end

    create_join_table :permissions, :roles, column_options: { type: :uuid, index: true }
    add_foreign_key :permissions_roles, :permissions, type: :uuid
    add_foreign_key :permissions_roles, :roles, type: :uuid
  end
end
