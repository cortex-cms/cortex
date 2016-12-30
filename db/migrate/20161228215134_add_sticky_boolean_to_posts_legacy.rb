class AddStickyBooleanToPostsLegacy < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :is_sticky, :boolean, default: false
  end
end
