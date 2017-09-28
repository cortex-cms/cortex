class AddNameToFields < ActiveRecord::Migration[5.1]
  def change
    add_column :fields, :name, :string, index: true
  end
end
