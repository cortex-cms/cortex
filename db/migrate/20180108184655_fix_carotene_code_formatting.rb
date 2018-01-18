require 'csv'

class FixCaroteneCodeFormatting < ActiveRecord::Migration[5.0]
  def change
    new_carotenes = CSV.read(Rails.root.join('db/seeds/carotene_v3.1.csv'), {headers: true, col_sep: ','})

    CSV.foreach(Rails.root.join('db/seeds/carotene_v3.1_old.csv'), {headers: true, col_sep: ','}) do |carotene|
      record = Carotene.find_by(title: carotene['GroupTitle'].strip, code: carotene['CID'].strip)

      new_carotene = new_carotenes.find {|row| row['ID'] == carotene['ID']}
      record.code = new_carotene['CID'].strip
      record.save!
    end
  end
end
