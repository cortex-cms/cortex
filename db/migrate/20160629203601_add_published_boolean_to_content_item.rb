class AddPublishedBooleanToContentItem < ActiveRecord::Migration[5.1]
  def change
    add_column :content_items, :is_published, :boolean, default: false
    add_column :permissions, :resource_id, :uuid
  end
end
