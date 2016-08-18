class RemoveAuthorFromContentItem < ActiveRecord::Migration
  def change
    remove_column :content_items, :author_id, :integer
  end
end
