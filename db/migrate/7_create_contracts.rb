class CreateContracts < ActiveRecord::Migration[5.1]
  def change
    create_table :contracts, id: :uuid do |t|
      t.string :name, null: false, index: true
      t.references :tenant, type: :uuid, null: false, foreign_key: true

      t.datetime :deleted_at, index: true
      t.timestamps null: false
    end
  end
end
