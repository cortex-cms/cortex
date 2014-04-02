class ChangeMediumColumn < ActiveRecord::Migration
  def change
    rename_column :media_posts, :medium_id, :media_id
  end
end
