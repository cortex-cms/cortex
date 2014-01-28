class AddTenantIdToUser < ActiveRecord::Migration
  def change
    change_column :tenants, :user_id, :integer, null: true
    add_column :users, :tenant_id, :integer, null: false
    add_index :users, :tenant_id
  end
end
