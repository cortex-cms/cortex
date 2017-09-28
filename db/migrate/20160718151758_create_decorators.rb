class CreateDecorators < ActiveRecord::Migration[5.1]
  def change
    create_table :decorators do |t|
      t.string     :name
      t.jsonb      :data

      t.timestamps null: false
    end
  end
end
