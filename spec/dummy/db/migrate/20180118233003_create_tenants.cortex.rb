# This migration comes from cortex (originally 2)
class CreateTenants < ActiveRecord::Migration[5.1]
  def change
    create_table :cortex_tenants, id: :uuid do |t|
      t.string :name, limit: 50, null: false, index: { unique: true }
      t.string :name_id, null: false, index: { unique: true }
      t.text :description
      t.uuid :parent_id, index: true
      t.integer :lft
      t.integer :rgt
      t.integer :depth
      t.datetime :deleted_at
      t.datetime :active_at
      t.datetime :deactive_at
      t.references :owner, type: :uuid, foreign_key: { to_table: :cortex_users }

      t.datetime :deleted_at, index: true
      t.timestamps
    end

    create_join_table :tenants, :users, table_name: :cortex_tenants_users, column_options: { type: :uuid, index: true }
    add_foreign_key :cortex_tenants_users, :cortex_tenants, column: :tenant_id, type: :uuid
    add_foreign_key :cortex_tenants_users, :cortex_users, column: :user_id, type: :uuid

    add_reference :cortex_users, :active_tenant, type: :uuid, foreign_key: { to_table: :cortex_tenants }
  end
end
