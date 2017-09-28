class AddUpdatedByToContentItem < ActiveRecord::Migration[5.1]
  def change
    add_reference :content_items, :updated_by, type: :uuid, null: true, foreign_key: { to_table: :users }
  end
end
