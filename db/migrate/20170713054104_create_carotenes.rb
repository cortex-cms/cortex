class CreateCarotenes < ActiveRecord::Migration[5.0]
  def change
    create_table :carotenes, id: :uuid do |t|
      t.citext :title, null: false
      t.string :code, null: false
      t.citext :cdptitle, null: false

      t.timestamps null: false
    end

    add_index :carotenes, :code
    add_index :carotenes, :title
  end
end
