require 'nokogiri'

class Post < ActiveRecord::Base
  include SearchablePost

  default_scope -> { includes(:categories, :media, :industries) }
  scope :published, -> { where('published_at <= ? and draft = ?', DateTime.now, false) }
  scope :published_last_updated_at, -> { published.order(updated_at: :desc).select('updated_at').first.updated_at }

  acts_as_taggable

  before_save :update_media!

  has_and_belongs_to_many :media, class_name: 'Media'
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :industries, class_name: '::Onet::Occupation',
                                       association_foreign_key: 'onet_occupation_id'

  belongs_to :author
  belongs_to :user # TODO: rename creator
  belongs_to :featured_media, class_name: 'Media'
  belongs_to :tile_media, class_name: 'Media'
  belongs_to :primary_category, class_name: 'Category'
  belongs_to :primary_industry, class_name: '::Onet::Occupation'

  validate :primary_category_must_be_in_categories, :primary_industry_must_be_in_industries
  validates :title, presence: true, length: { minimum: 1, maximum: 255 }
  validates :type, :job_phase, :display, presence: true, allow_nil: false

  enum job_phase: ['Discovery', 'Find the Job', 'Get the Job', 'On the Job']
  enum display: [:large, :medium, :small]

  validates :type, inclusion: { in: %w(Post ArticlePost InfographicPost PromoPost VideoPost) }

  def published?
    !draft && published_at ? published_at <= DateTime.now : false
  end

  class << self
    def find_by_id_or_slug(id_or_slug)
      if id_or_slug.to_s =~ /^\d+$/
        Post.find_by id: id_or_slug.to_i
      else
        Post.find_by slug: id_or_slug
      end
    end
  end

  private

  def update_media!
    self.media = find_all_associated_media
  end

  def find_all_associated_media
    find_media_from_body.push(self.featured_media, self.tile_media).compact.uniq
  end

  def find_media_from_body
    document = Nokogiri::HTML::Document.parse(body)
    media_ids = document.xpath('//@data-media-id').map{|element| element.to_s }
    Media.find(media_ids)
  end

  def primary_category_must_be_in_categories
    unless categories.to_a.empty? || categories.collect{ |c| c.id}.include?(primary_category_id)
      errors.add(:primary_category_id, 'must be in categories')
    end
  end

  def primary_industry_must_be_in_industries
    unless industries.to_a.empty? || industries.collect{ |i| i.id}.include?(primary_industry_id)
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
