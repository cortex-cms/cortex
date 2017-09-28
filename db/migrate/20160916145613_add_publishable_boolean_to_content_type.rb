class AddPublishableBooleanToContentType < ActiveRecord::Migration[5.1]
  def change
    add_column :content_types, :publishable, :boolean, default: false
  end
end
