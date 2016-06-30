class CreatePermissionsAndRolePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :name
      t.string :resource_type

      t.timestamps null: false
    end

    create_table :role_permissions do |t|
      t.belongs_to :role
      t.belongs_to :permission

      t.timestamps null: false
    end
  end
end
