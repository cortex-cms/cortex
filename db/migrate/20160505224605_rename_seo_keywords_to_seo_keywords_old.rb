# The reason this is renaming seo_keywords to seo_keywords_old is that
# acts_as_taggable has now reserved the method #seo_keywords to mean a
# list of tags. Since we still need to extract the data from the old
# seo_keywords I renamed it, allowing us to target it in the next migration.

class RenameSeoKeywordsToSeoKeywordsOld < ActiveRecord::Migration
  def change
    rename_column :webpages, :seo_keywords, :seo_keywords_old
  end
end
