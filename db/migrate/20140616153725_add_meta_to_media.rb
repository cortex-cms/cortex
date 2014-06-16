class AddMetaToMedia < ActiveRecord::Migration
  def up
    execute 'CREATE EXTENSION hstore'
    add_column :media, :meta, :hstore
    add_column :media, :type, :string, default: 'Media', null: false
    change_column :media, :digest, :string, null: true
  end

  def down
    remove_column :media, :meta
    remove_column :media, :type
    execute 'DROP EXTENSION hstore'
  end
end
