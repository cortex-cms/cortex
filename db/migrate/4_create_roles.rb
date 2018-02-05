class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :cortex_roles, id: :uuid do |t|
      t.string :name, index: true
      t.references :resource, type: :uuid, polymorphic: true, index: true

      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end

    create_join_table :roles, :users, table_name: :cortex_roles_users, column_options: { type: :uuid, index: true }
    add_foreign_key :cortex_roles_users, :cortex_roles, column: :role_id, type: :uuid
    add_foreign_key :cortex_roles_users, :cortex_users, column: :user_id, type: :uuid
  end
end
