class CreateFieldTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :field_types, id: :uuid
  end
end
