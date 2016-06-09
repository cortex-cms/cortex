class AddValidationsToFields < ActiveRecord::Migration
  def change
    add_column :fields, :validations, :jsonb, default: {}
  end
end
