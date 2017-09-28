class RemoveAuthorFromContentItem < ActiveRecord::Migration[5.1]
  def change
    remove_column :content_items, :author_id, :integer
  end
end
