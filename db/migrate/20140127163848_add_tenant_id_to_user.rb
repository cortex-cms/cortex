class AddTenantIdToUser < ActiveRecord::Migration[5.1]
  def change
    change_column :tenants, :user_id, :uuid, null: true
    add_column :users, :tenant_id, :uuid, null: false
    add_index :users, :tenant_id
  end
end
