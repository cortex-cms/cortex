class CreatePermissionsAndRolePermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :permissions, id: :uuid do |t|
      t.string :name
      t.string :resource_type

      t.timestamps null: false
    end

    create_table :role_permissions, id: :uuid do |t|
      t.references :role, type: :uuid, foreign_key: true
      t.references :permission, type: :uuid, foreign_key: true

      t.timestamps null: false
    end
  end
end
