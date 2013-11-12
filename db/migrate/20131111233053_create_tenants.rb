class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :name
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth
      t.string :contact_name
      t.string :contact_email
      t.string :contact_phone
      t.datetime :active_at
      t.datetime :inactive_at
      t.string :contract
      t.string :did

      t.timestamps
    end
  end
end
