class AddCardGroupToWebpages < ActiveRecord::Migration[5.0]
  def change
    add_column :webpages, :card_group_widget, :jsonb
  end
end
