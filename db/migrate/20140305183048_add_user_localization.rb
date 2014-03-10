class AddUserLocalization < ActiveRecord::Migration
  def up
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :locale, :string, limit: 30, null: false, default: 'en_US'
    add_column :users, :timezone, :string, limit: 30, null: false, default: 'EST'

    execute 'UPDATE users SET firstname=email'

    change_column :users, :firstname, :string, null: false
  end

  def down
    remove_column :users, :firstname
    remove_column :users, :lastname
    remove_column :users, :locale
    remove_column :users, :timezone
  end
end
