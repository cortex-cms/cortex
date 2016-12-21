class AddDynamicYieldMetadataToWebpages < ActiveRecord::Migration[5.0]
  def change
    add_column :webpages, :dynamic_yield_sku, :string
    add_column :webpages, :dynamic_yield_category, :string
  end
end
