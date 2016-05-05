class RemoveSeoKeywordOldFromWebpages < ActiveRecord::Migration
  def change
    remove_column :webpages, :seo_keywords_old
  end
end
