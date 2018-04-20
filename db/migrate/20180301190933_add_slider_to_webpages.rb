class AddSliderToWebpages < ActiveRecord::Migration[5.0]
  def change
    add_column :webpages, :slider_widget, :jsonb
  end
end
