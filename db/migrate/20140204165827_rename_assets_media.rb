class RenameAssetsMedia < ActiveRecord::Migration
  def up
    rename_table :assets, :media
  end

  def down
    rename_table :media, :assets
  end
end
