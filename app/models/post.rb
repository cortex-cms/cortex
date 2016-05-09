class Post < ActiveRecord::Base
  include SearchablePost
  include FindByTenant

  default_scope -> { includes(:categories, :media, :industries) }
  scope :published, -> { scope :published, -> { where('published_at <= ? and draft = ? and (expired_at >= ? OR expired_at is null)', DateTime.now, false, DateTime.now) }
  scope :last_updated_at, -> { order(updated_at: :desc).select('updated_at').first.updated_at }
  scope :find_by_body_text, ->(query) { where("body LIKE :query", query: "%#{query}%") }

  acts_as_taggable
  acts_as_taggable_on :seo_keywords

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
    !(draft || expired? || pending?)
  end

  def expired?
    expired_at ? expired_at <= DateTime.now : false
  end

  def pending?
    published_at ? published_at >= DateTime.now : false
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
