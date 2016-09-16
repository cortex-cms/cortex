class RemoveUnnecessaryFieldsFromContentType < ActiveRecord::Migration
  def change
    remove_column :content_types, :taggable_with_tags?, :boolean
    remove_column :content_types, :taggable_with_keywords?, :boolean
    remove_column :content_types, :is_published, :boolean
  end
end
