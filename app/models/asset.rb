class Asset < ActiveRecord::Base
  belongs_to :user
  has_attached_file :attachment
end
