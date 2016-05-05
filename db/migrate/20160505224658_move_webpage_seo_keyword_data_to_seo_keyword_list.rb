# Pretty straight forward - is a block that moves all the string data from
# seo_keywords_old (recently renamed) to the acts_as_taggable list using the
# #add method. This is done to preserve existing data before this refactor was
# made.

class MoveWebpageSeoKeywordDataToSeoKeywordList < ActiveRecord::Migration
  def change
    Webpage.all.each do |w|
      unless w.seo_keywords_old.nil?
        keywords = w.seo_keywords_old.split(" ")
        keywords.each { |k| w.seo_keyword_list.add(k) }
        w.save
      end
    end
  end
end
