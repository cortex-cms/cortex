class AddPublishDateToContentItem < ActiveRecord::Migration[5.1]
  def change
    add_column :content_items, :publish_date, :datetime
  end
end
