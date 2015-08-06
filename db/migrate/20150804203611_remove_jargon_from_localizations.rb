class RemoveJargonFromLocalizations < ActiveRecord::Migration
  def change
    remove_column :localizations, :jargon_id
  end
end
