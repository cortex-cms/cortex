class AssetsPost < ActiveRecord::Base
  self.primary_keys = :asset_id, :post_id
  belongs_to :asset
  belongs_to :post
end