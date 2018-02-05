# This migration comes from cortex (originally 8)
class CreateDecorators < ActiveRecord::Migration[5.1]
  def change
    create_table :cortex_decorators, id: :uuid do |t|
      t.string :name, null: false, index: true
      t.jsonb :data, null: false, default: {}
      t.references :tenant, type: :uuid, null: false, foreign_key: { to_table: :cortex_tenants }

      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end

    create_table :cortex_contentable_decorators, id: :uuid do |t|
      t.references :decorator, type: :uuid, foreign_key: { to_table: :cortex_decorators }
      t.references :contentable, type: :uuid, polymorphic: true, index: { name: 'index_cortex_contentable_decorators_on_contentable' }
      t.references :tenant, type: :uuid, null: false, foreign_key: { to_table: :cortex_tenants }

      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end
  end
end
