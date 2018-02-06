# This migration comes from cortex (originally 6)
class CreateFlipperTables < ActiveRecord::Migration[5.1]
  def self.up
    create_table :cortex_flipper_features, id: :uuid do |t|
      t.string :key, null: false, index: { unique: true }
      t.timestamps null: false
    end

    create_table :cortex_flipper_gates, id: :uuid do |t|
      t.string :feature_key, null: false, index: { unique: true }
      t.string :key, null: false, index: { unique: true }
      t.string :value, index: { unique: true }
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :cortex_flipper_gates
    drop_table :cortex_flipper_features
  end
end
