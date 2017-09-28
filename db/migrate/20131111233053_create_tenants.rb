class CreateTenants < ActiveRecord::Migration[5.1]
  def change
    create_table :tenants, id: :uuid do |t|
      t.string :name, limit: 50, null: false, index: { unique: true }
      t.text :description
      t.uuid :parent_id, index: true
      t.integer :lft
      t.integer :rgt
      t.integer :depth
      t.datetime :deleted_at
      t.datetime :active_at
      t.datetime :deactive_at
      t.references :owner, type: :uuid, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
