class AssetsPost < ActiveRecord::Base
  set_primary_keys :asset_id, :post_id
  belongs_to :asset
  belongs_to :post
end