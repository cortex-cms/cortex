class RemoveJargonFromLocalizations < ActiveRecord::Migration[5.1]
  def change
    remove_column :localizations, :jargon_id
  end
end
