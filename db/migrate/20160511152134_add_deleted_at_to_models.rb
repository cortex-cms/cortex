class AddDeletedAtToModels < ActiveRecord::Migration[5.1]
  def change
    add_column :content_items, :deleted_at, :datetime
    add_index :content_items, :deleted_at

    add_column :fields, :deleted_at, :datetime
    add_index :fields, :deleted_at

    add_column :field_items, :deleted_at, :datetime
    add_index :field_items, :deleted_at

    add_column :content_types, :deleted_at, :datetime
    add_index :content_types, :deleted_at
  end
end
