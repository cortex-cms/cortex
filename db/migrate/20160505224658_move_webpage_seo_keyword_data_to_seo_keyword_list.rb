class MoveWebpageSeoKeywordDataToSeoKeywordList < ActiveRecord::Migration
  def up
    Webpage.all.each do |w|
      unless w.seo_keywords_old.nil?
        keywords = w.seo_keywords_old.split(" ")
        keywords.each { |k| w.seo_keyword_list.add(k) }
        w.save
      end
    end
  end

  def down
    #Not Yet Implemented
  end
end
