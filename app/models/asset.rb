class Asset < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable
  has_attached_file :attachment
end
