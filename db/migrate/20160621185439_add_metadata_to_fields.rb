class AddMetadataToFields < ActiveRecord::Migration[5.1]
  def change
    add_column :fields, :metadata, :jsonb
  end
end
