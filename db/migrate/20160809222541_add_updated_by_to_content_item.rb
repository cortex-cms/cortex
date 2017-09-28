class AddUpdatedByToContentItem < ActiveRecord::Migration[5.1]
  def change
    add_column :content_items, :updated_by_id, :integer, :null => true
  end
end
