class CreateTenants < ActiveRecord::Migration[5.1]
  def change
    create_table :tenants, id: :uuid do |t|
      t.string :name, limit: 50, null: false
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth
      t.datetime :deleted_at
      t.datetime :active_at
      t.datetime :deactive_at
      t.integer :user_id, null: false, index: true

      t.timestamps
    end
    add_index :tenants, :parent_id
  end
end
