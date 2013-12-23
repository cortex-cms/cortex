class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :name, index: true
      t.belongs_to :user, index: true
      t.attachment :attachment
      t.string :dimensions
      t.text :description
      t.string :alt
      t.boolean :status
      t.datetime :deactive_at

      t.timestamps
    end
  end
end
