class AddTablesWidgetToWebpage < ActiveRecord::Migration[5.0]
  def change
    add_column :webpages, :tables_widget, :jsonb
  end
end
