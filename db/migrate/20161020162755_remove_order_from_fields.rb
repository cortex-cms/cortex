class RemoveOrderFromFields < ActiveRecord::Migration[5.1]
  def change
    remove_column :fields, :order, :integer
  end
end
