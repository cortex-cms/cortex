class AddFirstnameLastnameToAuthor < ActiveRecord::Migration
  def up
    add_column :authors, :firstname, :string
    add_column :authors, :lastname, :string
    execute 'UPDATE authors SET firstname=name'
    remove_column :authors, :name
  end

  def down
    add_column :authors, :name, :string
    execute "UPDATE authors SET name=firstname + ' ' + lastname"
    remove_column :authors, :firstname, :string
    remove_column :authors, :lastname, :string
  end
end
