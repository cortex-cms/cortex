# This migration comes from cortex (originally 13)
class CreateFieldTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :cortex_field_types, id: :uuid
  end
end
