class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :user_id, null: false, index: true
      t.string :name
      t.text :body
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end
