class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :name, limit: 50, null: false
      t.string :subdomain, limit: 20
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth
      t.string :contact_name, limit: 50
      t.string :contact_email, limit: 200
      t.string :contact_phone, limit: 20
      t.datetime :deleted_at
      t.string :contract
      t.string :did, index: true
      t.datetime :active_at
      t.datetime :deactive_at
      t.integer :user_id, null: false, index: true

      t.timestamps
    end
    add_index :tenants, :parent_id
  end
end
