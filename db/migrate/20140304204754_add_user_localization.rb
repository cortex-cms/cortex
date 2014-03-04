class AddUserLocalization < ActiveRecord::Migration
  def up
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :locale, :string, limit: 30, default: 'UTC'
    add_column :users, :timezone, :string, limit: 30, default: 'en_US'

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
