class CreateDecorators < ActiveRecord::Migration
  def change
    create_table :decorators do |t|
      t.string     :name
      t.jsonb      :data

      t.timestamps null: false
    end
  end
end
