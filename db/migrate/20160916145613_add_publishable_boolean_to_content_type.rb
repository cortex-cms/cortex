class AddPublishableBooleanToContentType < ActiveRecord::Migration
  def change
    add_column :content_types, :publishable, :boolean
  end
end
