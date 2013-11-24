class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :name
      t.integer :parent_id
      t.belongs_to :organization
      t.integer :lft
      t.integer :rgt
      t.integer :depth
      t.string :contact_name
      t.string :contact_email
      t.string :contact_phone
      t.datetime :deleted_at
      t.string :contract
      t.string :did

      t.timestamps
    end
  end
end
