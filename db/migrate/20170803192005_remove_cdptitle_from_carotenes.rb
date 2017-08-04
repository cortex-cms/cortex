class RemoveCdptitleFromCarotenes < ActiveRecord::Migration[5.0]
  def change
    remove_column :carotenes, :cdptitle, :citext
  end
end
