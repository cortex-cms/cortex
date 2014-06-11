require 'nokogiri'

class Post < ActiveRecord::Base
  include SearchablePost

  default_scope { includes(:categories, :media) }
  scope :published, -> { where('published_at <= ?', DateTime.now) }

  acts_as_taggable

  before_save :update_media!, :sanitize_body!

  has_and_belongs_to_many :media, class_name: 'Media'
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :industries, class_name: '::Onet::Occupation',
                                       association_foreign_key: 'onet_occupation_id'

  belongs_to :user
  belongs_to :featured_media, class_name: 'Media'
  belongs_to :primary_category, class_name: 'Category'
  belongs_to :primary_industry, class_name: '::Onet::Occupation'

  validate :primary_category_must_be_in_categories, :primary_industry_must_be_in_industries
  validates :title, :author, :copyright_owner, presence: true, length: { minimum: 1, maximum: 255 }
  validates :short_description, presence: true, length: { minimum: 25, maximum: 255 }
  validates :tag_list, :seo_title, :seo_description, length: { maximum: 255 }
  validates :type, :job_phase, :display, presence: true, allow_nil: false
  validates :primary_industry_id, :primary_category_id, presence: true

  enum type: [:article, :video, :infographic, :promo]
  enum job_phase: [:discovery, :find_the_job, :get_the_job, :on_the_job]
  enum display: [:large, :medium, :small]

  self.inheritance_column = nil

  def published?
    published_at ? published_at <= DateTime.now : false
  end

  class << self
    def find_by_id_or_slug(id_or_slug)
      Post.where('id = ? OR slug = ?', id_or_slug.to_i, id_or_slug).first
    end
  end

  private

  def update_media!
    self.media = find_all_associated_media
  end

  def sanitize_body!
    if self.body
      Sanitize.clean!(self.body, Cortex.config.sanitize_whitelist.post)
    end
  end

  def find_all_associated_media
    find_media_from_body.push(self.featured_media).compact.uniq
  end

  def find_media_from_body
    document = Nokogiri::HTML::Document.parse(body)
    media_ids = document.xpath('//@data-media-id').map{|element| element.to_s }
    Media.find(media_ids)
  end

  def primary_category_must_be_in_categories
    unless categories.collect{ |c| c.id}.include? primary_category_id
      errors.add(:primary_category_id, 'must be in categories')
    end
  end

  def primary_industry_must_be_in_industries
    unless industries.collect{ |i| i.id}.include? primary_industry_id
      errors.add(:primary_industry_id, 'must be in industries')
    end
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
