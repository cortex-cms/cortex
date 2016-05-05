# Deletes the seo_keywords_old column since we no longer need it after extracting
# the data into seo_keyword_list.

class RemoveSeoKeywordOldFromWebpages < ActiveRecord::Migration
  def change
    remove_column :webpages, :seo_keywords_old
  end
end
