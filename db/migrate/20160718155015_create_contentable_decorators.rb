class CreateContentableDecorators < ActiveRecord::Migration
  def change
    create_table :contentable_decorators do |t|
      t.references :decorator
      t.references :contentable, polymorphic: true

      t.timestamps null: false
    end
  end
end
