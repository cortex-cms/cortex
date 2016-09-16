class RemoveUnnecessaryFieldsFromContentType < ActiveRecord::Migration
  def change
    remove_column :content_types, :taggable_with_tags?
    remove_column :content_types, :taggable_with_keywords?
    remove_column :content_types, :is_published
  end
end
