class CreateContentDecorators < ActiveRecord::Migration
  def change
    create_table :content_decorators do |t|
      t.references :decorator
      t.references :contentable, polymorphic: true

      t.timestamps null: false
    end
  end
end
