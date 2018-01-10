class RemoveDynamicYieldFromWebpages < ActiveRecord::Migration[5.0]
  def change
    remove_column :webpages, :dynamic_yield_sku, :string
    remove_column :webpages, :dynamic_yield_category, :string
  end
end
