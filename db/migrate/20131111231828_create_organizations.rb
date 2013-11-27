class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :subdomain, :null => false, :limit => 20
      t.string :name, :null => false, :limit => 50
      t.string :contact_name, :limit => 50
      t.string :contact_email, :limit => 200
      t.string :contact_phone, :limit => 20

      t.timestamps
    end
  add_index :organizations, :name, :unique => true
  end
end