class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :null => false, :limit => 50
      t.string :password, :null => false, :limit => 250
      t.string :email, :null => false, :limit => 200

      t.timestamps
    end
    add_index :users, :name, :unique => true
  end
end