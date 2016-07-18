class CreateDecorators < ActiveRecord::Migration
  def change
    create_table :decorators do |t|
      t.string     :decorator_type
      t.jsonb      :decorator_data
      t.references :viewable, polymorphic: true

      t.timestamps null: false
    end
  end
end
