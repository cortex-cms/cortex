class AddDataToLocales < ActiveRecord::Migration
  def change
    add_column :locales, :data, :text
  end
end
