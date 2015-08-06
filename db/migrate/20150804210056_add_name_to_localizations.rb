class AddNameToLocalizations < ActiveRecord::Migration
  def change
    add_column :localizations, :name, :string
    Localization.update_all 'name=id' # Set :name to :id on initial migration, as :name must be unique
    change_column :localizations, :name, :string, :null => false
  end
end
