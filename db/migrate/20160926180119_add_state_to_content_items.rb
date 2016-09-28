class AddStateToContentItems < ActiveRecord::Migration
  def change
    add_column :content_items, :state, :string
  end
end
