class AddIconToTenants < ActiveRecord::Migration
  def change
    add_column :tenants, :icon, :string, default: "palette"
  end
end
