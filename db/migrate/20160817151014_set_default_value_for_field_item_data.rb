class SetDefaultValueForFieldItemData < ActiveRecord::Migration
  def change
    change_column_default :field_items, :data, {}
  end
end
