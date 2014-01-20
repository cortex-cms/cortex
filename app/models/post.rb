class Post < ActiveRecord::Base
  acts_as_taggable
  has_many :assets_posts
  has_many :categories_posts
  has_many :assets, through: :assets_posts
  has_many :categories, through: :categories_posts
  belongs_to :user

  self.inheritance_column = nil
end

# == Schema Information
#
# Table name: posts
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  title         :string(255)
#  type          :string(255)
#  published_at  :datetime
#  expired_at    :datetime
#  deleted_at    :datetime
#  draft         :boolean          default(TRUE), not null
#  comment_count :integer          default(0), not null
#  body          :text
#  created_at    :datetime
#  updated_at    :datetime
#
# == Not Present
#  created_by    :integer          not null