class RenameSeoKeywordsToSeoKeywordsOld < ActiveRecord::Migration
  def change
    rename_column :webpages, :seo_keywords, :seo_keywords_old
  end
end
