class CreateContentItems < ActiveRecord::Migration[5.1]
  def change
    create_table :cortex_content_items, id: :uuid do |t|
      t.string :state, index: true
      t.references :content_type, type: :uuid, null: false, foreign_key: { to_table: :cortex_content_types }
      t.references :tenant, type: :uuid, null: false, foreign_key: { to_table: :cortex_tenants }
      t.references :creator, type: :uuid, null: false, foreign_key: { to_table: :cortex_users }
      t.references :updated_by, type: :uuid, foreign_key: { to_table: :cortex_users }

      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end
  end
end
