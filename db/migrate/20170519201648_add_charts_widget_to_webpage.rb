class AddChartsWidgetToWebpage < ActiveRecord::Migration[5.0]
  def change
    add_column :webpages, :charts_widget, :jsonb
  end
end
