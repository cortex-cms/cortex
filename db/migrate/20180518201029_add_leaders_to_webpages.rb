class AddLeadersToWebpages < ActiveRecord::Migration[5.0]
  def change
    add_column :webpages, :leaders_widget, :jsonb
  end
end
