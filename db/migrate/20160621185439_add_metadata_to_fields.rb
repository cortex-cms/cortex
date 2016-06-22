class AddMetadataToFields < ActiveRecord::Migration
  def change
    add_column :fields, :metadata, :jsonb
  end
end
