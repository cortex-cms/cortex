class AddMetaToMedia < ActiveRecord::Migration
  def up
    execute 'CREATE EXTENSION IF NOT EXISTS hstore'
    add_column :media, :meta, :hstore
    add_column :media, :type, :string, default: 'Media', null: false
    change_column :media, :digest, :string, null: true
  end

  def down
    execute 'DROP EXTENSION IF EXISTS hstore'
    remove_column :media, :meta
    remove_column :media, :type
  end
end
