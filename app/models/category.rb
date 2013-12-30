class Category < ActiveRecord::Base
  acts_as_nested_set
  belongs_to :user
  has_many :categories_posts
  has_many :posts, through: :categories_posts
end

# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_by :integer          not null
#  parent_id  :integer
#  lft        :integer
#  rgt        :integer
#  depth      :integer
#  created_at :datetime
#  updated_at :datetime
#
