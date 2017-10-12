class AddGalleriesWidgetToWebpage < ActiveRecord::Migration[5.0]
  def change
    add_column :webpages, :galleries_widget, :jsonb
  end
end
