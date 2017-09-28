class AddStateToContentItems < ActiveRecord::Migration[5.1]
  def change
    add_column :content_items, :state, :string
  end
end
