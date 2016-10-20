class RemoveOrderFromFields < ActiveRecord::Migration
  def change
    remove_column :fields, :order, :integer
  end
end
