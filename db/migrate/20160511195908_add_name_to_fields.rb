class AddNameToFields < ActiveRecord::Migration
  def change
    add_column :fields, :name, :string
  end
end
