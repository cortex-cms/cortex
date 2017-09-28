class CreateDecorators < ActiveRecord::Migration[5.1]
  def change
    create_table :decorators, id: :uuid do |t|
      t.string     :name, index: true
      t.jsonb      :data

      t.timestamps null: false
    end
  end
end
