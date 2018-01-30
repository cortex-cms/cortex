# This migration comes from cortex (originally 5)
class CreatePermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :cortex_permissions, id: :uuid do |t|
      t.string :name, index: true
      t.string :resource_type, index: true
      t.uuid :resource_id, index: true

      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end

    create_join_table :permissions, :roles, table_name: :cortex_permissions_roles, column_options: { type: :uuid, index: true }
    add_foreign_key :cortex_permissions_roles, :cortex_permissions, column: :permission_id, type: :uuid
    add_foreign_key :cortex_permissions_roles, :cortex_roles, column: :role_id, type: :uuid
  end
end
