class TenantOwner < ActiveRecord::Migration[5.1]
  def change
    rename_column :tenants, :user_id, :owner_id
  end
end
