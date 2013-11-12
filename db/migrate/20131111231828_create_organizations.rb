class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :display_name

      t.timestamps
    end
  add_index :organizations, :name, :unique => true
  end
end
