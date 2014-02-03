class Post < ActiveRecord::Base
  acts_as_taggable

  has_and_belongs_to_many :assets
  has_and_belongs_to_many :categories
  belongs_to :user

  validates_presence_of :title
  validates_presence_of :short_description
  validates_presence_of :author

  enum type: [:article, :video, :infographic, :promo]
  enum job_phase: [:discovery, :find_the_job, :get_the_job, :on_the_job]
  enum display: [:large, :medium, :small]

  self.inheritance_column = nil
end

# == Schema Information
#
# Table name: posts
#
#  id                 :integer          not null, primary key
#  user_id            :integer          not null
#  title              :string(255)
#  published_at       :datetime
#  expired_at         :datetime
#  deleted_at         :datetime
#  draft              :boolean          default(TRUE), not null
#  comment_count      :integer          default(0), not null
#  body               :text
#  created_at         :datetime
#  updated_at         :datetime
#  short_description  :string(255)
#  job_phase          :integer          not null
#  display            :integer          not null
#  featured_image_url :string(255)
#  notes              :text
#  copyright_owner    :string(255)
#  seo_title          :string(255)
#  seo_description    :string(255)
#  seo_preview        :string(255)
#  type               :integer          not null
#  author             :string
#
