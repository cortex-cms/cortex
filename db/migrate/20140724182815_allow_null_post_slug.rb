class AllowNullPostSlug < ActiveRecord::Migration
  def change
    change_column :posts, :slug, :string
  end
end
