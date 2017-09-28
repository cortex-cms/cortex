class CreateFieldTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :field_types do |t|
      t.timestamps null: false
    end
  end
end
