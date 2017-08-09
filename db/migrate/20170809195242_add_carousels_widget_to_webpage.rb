class AddCarouselsWidgetToWebpage < ActiveRecord::Migration[5.0]
  def change
    add_column :webpages, :carousels_widget, :jsonb
  end
end
