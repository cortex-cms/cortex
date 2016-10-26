class AddDefaultToMetadata < ActiveRecord::Migration
  def change
    change_column_default :fields, :metadata, default: {}
  end
end
