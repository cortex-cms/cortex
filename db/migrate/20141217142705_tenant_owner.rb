class TenantOwner < ActiveRecord::Migration
  def change
    rename_column :tenants, :user_id, :owner_id
  end
end
