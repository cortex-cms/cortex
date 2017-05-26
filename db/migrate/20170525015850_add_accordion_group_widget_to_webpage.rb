class AddAccordionGroupWidgetToWebpage < ActiveRecord::Migration[5.0]
  def change
    add_column :webpages, :accordion_group_widget, :jsonb
  end
end
