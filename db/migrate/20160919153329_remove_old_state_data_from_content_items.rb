class RemoveOldStateDataFromContentItems < ActiveRecord::Migration
  def change
    remove_column :content_items, :publish_state, :string
    remove_column :content_items, :published_at, :datetime
    remove_column :content_items, :expired_at, :datetime
  end
end
