class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :name
      t.belongs_to :user, index: true
      t.attachment :attachment
      t.text :description
      t.datetime :deactive_at

      t.timestamps
    end
  end
end
