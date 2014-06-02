class CreateOnetOccupations < ActiveRecord::Migration
  def change
    create_table :onet_occupations do |t|
      t.string :soc
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
