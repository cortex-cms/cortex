class ConvertUserIdFromUuidBackToIntegerOnContentItems < ActiveRecord::Migration
  def change
    remove_column :content_items, :creator_id, :uuid
    add_column :content_items, :creator_id, :integer, null: false
  end
end
