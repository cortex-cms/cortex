class AddValidationsToFields < ActiveRecord::Migration[5.1]
  def change
    add_column :fields, :validations, :jsonb, default: {}
  end
end
