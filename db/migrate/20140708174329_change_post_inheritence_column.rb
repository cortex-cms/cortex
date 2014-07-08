class ChangePostInheritenceColumn < ActiveRecord::Migration
  def up
    # enum type: [:article, :video, :infographic, :promo]
    execute "UPDATE posts SET post_type='ArticlePost' WHERE type=0"
    execute "UPDATE posts SET post_type='VideoPost' WHERE type=1"
    execute "UPDATE posts SET post_type='InfographicPost' WHERE type=2"
    execute "UPDATE posts SET post_type='PromoPost' WHERE type=3"

    remove_column :posts, :type
    rename_column :posts, :post_type, :type
    add_index :posts, :type
  end

  def down
    remove_index :posts, :type
    rename_column :posts, :type, :post_type
    add_column :posts, :type, :integer, default: 0, null: false

    execute "UPDATE posts SET type=0 WHERE post_type='ArticlePost'"
    execute "UPDATE posts SET type=1 WHERE post_type='VideoPost'"
    execute "UPDATE posts SET type=2 WHERE post_type='InfographicPost'"
    execute "UPDATE posts SET type=3 WHERE post_type='PromoPost'"
  end
end
