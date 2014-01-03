class AddDigestColumnToAssets < ActiveRecord::Migration
  def up
    Asset.destroy_all
    add_column :assets, :digest, :string, null: false
  end

  def down
    remove_column :assets, :digest
  end
end
