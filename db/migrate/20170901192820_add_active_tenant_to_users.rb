class AddActiveTenantToUsers < ActiveRecord::Migration[5.0]
  def change
    #add_column :users, :active_tenant, :integer, index: true
    add_reference :users, :active_tenant
    #add_foreign_key :users, :tenants, column: :active_tenant
    # add_column :users, :active_tenant, :integer, references: :tenants
    # add_foreign_key :users, :tenants, column: :active_tenant
  end
end
