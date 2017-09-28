class AddJsonColumnToFieldItems < ActiveRecord::Migration[5.1]
  def change
    remove_column :field_items, :text, :text
    add_column :field_items, :data, :jsonb
  end
end
