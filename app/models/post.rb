require 'nokogiri'

class Post < ActiveRecord::Base
  acts_as_taggable

  before_save :scan_media!

  has_and_belongs_to_many :media, class_name: 'Media'
  has_and_belongs_to_many :categories
  belongs_to :user

  validates :title, :author, :copyright_owner, presence: true, length: { minimum: 1, maximum: 255 }
  validates :short_description, presence: true, length: { minimum: 25, maximum: 255 }
  validates :tag_list, :seo_title, :seo_description, length: { maximum: 255 }
  validates :type, :job_phase, :display, presence: true, allow_nil: false

  enum type: [:article, :video, :infographic, :promo]
  enum job_phase: [:discovery, :find_the_job, :get_the_job, :on_the_job]
  enum display: [:large, :medium, :small]

  self.inheritance_column = nil

  private

  def scan_media!
    bodyDoc = Nokogiri::HTML::Document.parse(body)
    media_ids = bodyDoc.xpath('//@data-media-id').map{|element| element.to_s }

    self.media = Media.find(media_ids)
  end
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
