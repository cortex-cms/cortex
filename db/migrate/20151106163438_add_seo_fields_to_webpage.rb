class AddSeoFieldsToWebpage < ActiveRecord::Migration
  def change
    add_column :webpages, :seo_title, :string
    add_column :webpages, :seo_description, :text
    add_column :webpages, :noindex, :bool, default: false
    add_column :webpages, :nofollow, :bool, default: false
    add_column :webpages, :nosnippet, :bool, default: false
    add_column :webpages, :noodp, :bool, default: false
    add_column :webpages, :noarchive, :bool, default: false
    add_column :webpages, :noimageindex, :bool, default: false
  end
end
