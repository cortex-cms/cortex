class AddPublishedBooleanToContentType < ActiveRecord::Migration
  def change
    add_column :content_types, :is_published, :boolean, default: false
    add_column :permissions, :resource_id, :integer
  end
end
