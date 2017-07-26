class AddBuyBoxWidgetToWebpage < ActiveRecord::Migration[5.0]
  def change
    add_column :webpages, :buy_box_widget, :jsonb
  end
end
