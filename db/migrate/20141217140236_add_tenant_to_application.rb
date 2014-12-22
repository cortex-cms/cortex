class AddTenantToApplication < ActiveRecord::Migration
  def change
    add_reference :applications, :tenant, index: true
  end
end
