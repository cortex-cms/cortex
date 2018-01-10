class AddProductDataToWebpages < ActiveRecord::Migration[5.0]
  def change
    add_column :webpages, :product_data, :jsonb
  end
end
