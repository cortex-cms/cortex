class AddSeoKeywordsToWebpage < ActiveRecord::Migration
  def change
    add_column :webpages, :seo_keywords, :text
  end
end
