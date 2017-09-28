class CreateContentableDecorators < ActiveRecord::Migration[5.1]
  def change
    create_table :contentable_decorators, id: :uuid do |t|
      t.references :decorator, type: :uuid, foreign_key: true
      t.references :contentable, type: :uuid, polymorphic: true, index: { name: 'index_contentable_decorators_on_contentable' }

      t.timestamps null: false
    end
  end
end
