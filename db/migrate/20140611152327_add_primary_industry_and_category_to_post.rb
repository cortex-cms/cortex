class AddPrimaryIndustryAndCategoryToPost < ActiveRecord::Migration
  def up
    rename_column :posts, :industry_id, :primary_industry_id
    add_column :posts, :primary_category_id, :integer, index: true
    execute 'UPDATE posts p SET primary_category_id=cp.category_id ' +
            'FROM categories_posts cp WHERE p.id=cp.post_id'
    change_column :posts, :primary_category_id, :integer, index: true

    create_join_table :posts, :onet_occupations do |t|
      # t.index [:post_id, :onet_occupation_id]
      # t.index [:onet_occupation_id, :post_id]
    end

    execute 'INSERT INTO onet_occupations_posts (post_id, onet_occupation_id) ' +
            'SELECT id, primary_industry_id FROM posts WHERE primary_industry_id IS NOT NULL'
  end

  def down
    rename_column :posts, :primary_industry_id, :industry_id
    remove_column :posts, :primary_category_id
    drop_join_table :posts, :onet_occupations
  end
end
