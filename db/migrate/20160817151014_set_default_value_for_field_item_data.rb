class SetDefaultValueForFieldItemData < ActiveRecord::Migration[5.1]
  def change
    change_column_default :field_items, :data, {}
  end
end
