class CategoriesPost < ActiveRecord::Base
  self.primary_keys = :category_id, :post_id
  belongs_to :category
  belongs_to :post
end