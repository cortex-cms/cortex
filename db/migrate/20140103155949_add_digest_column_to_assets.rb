class AddDigestColumnToAssets < ActiveRecord::Migration
  def up
    execute 'DELETE FROM assets'
    add_column :assets, :digest, :string, null: false
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "Can't recover deleted assets"
  end
end
