class AddPublishDateToContentItem < ActiveRecord::Migration
  def change
    add_column :content_items, :publish_date, :datetime
  end
end
