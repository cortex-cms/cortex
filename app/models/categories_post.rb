class CategoriesPost < ActiveRecord::Base
  set_primary_keys :category_id, :post_id
  belongs_to :category
  belongs_to :post
end