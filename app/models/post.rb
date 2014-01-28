class Post < ActiveRecord::Base
  acts_as_taggable

  has_and_belongs_to_many :assets
  has_and_belongs_to_many :categories
  belongs_to :user

  self.inheritance_column = nil
end

# == Schema Information
#
# Table name: posts
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
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
