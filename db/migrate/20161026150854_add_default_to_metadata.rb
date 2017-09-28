class AddDefaultToMetadata < ActiveRecord::Migration[5.1]
  def change
    change_column_default :fields, :metadata, default: {}
  end
end
