class AddJsonColumnToFieldItems < ActiveRecord::Migration
  def change
    remove_column :field_items, :text, :text
    add_column :field_items, :data, :jsonb
  end
end
