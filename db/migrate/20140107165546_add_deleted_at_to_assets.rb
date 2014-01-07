class AddDeletedAtToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :deleted_at, :datetime
  end
end
