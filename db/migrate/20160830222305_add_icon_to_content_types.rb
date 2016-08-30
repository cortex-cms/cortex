class AddIconToContentTypes < ActiveRecord::Migration
  def change
    add_column :content_types, :icon, :string, :null => false, :default => 'help'
  end
end
