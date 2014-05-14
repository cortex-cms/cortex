require 'nokogiri'

class Post < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  scope :published, -> { where('published_at <= ?', DateTime.now) }

  acts_as_taggable

  before_save :update_media!

  has_and_belongs_to_many :media, class_name: 'Media'
  has_and_belongs_to_many :categories
  belongs_to :user
  belongs_to :featured_media, class_name: 'Media'

  validates :title, :author, :copyright_owner, presence: true, length: { minimum: 1, maximum: 255 }
  validates :short_description, presence: true, length: { minimum: 25, maximum: 255 }
  validates :tag_list, :seo_title, :seo_description, length: { maximum: 255 }
  validates :type, :job_phase, :display, presence: true, allow_nil: false

  enum type: [:article, :video, :infographic, :promo]
  enum job_phase: [:discovery, :find_the_job, :get_the_job, :on_the_job]
  enum display: [:large, :medium, :small]

  self.inheritance_column = nil

  mapping do
    indexes :id,                :index => :not_analyzed
    indexes :title,             :analyzer => 'snowball'
    indexes :body,              :analyzer => 'snowball'
    indexes :draft,             :type => 'boolean'
    indexes :short_description, :analyzer => 'snowball'
    indexes :copyright_owner,   :analyzer => 'keyword'
    indexes :author,            :analyzer => 'keyword'
    indexes :published_at,      :type => 'date', :include_in_all => false
    indexes :tags,              :analyzer => :keyword, :as => 'tag_list'
    indexes :categories,        :analyzer => :keyword, :as => 'categories.collect{ |c| c.name }'
    indexes :job_phase,         :analyzer => :keyword
  end

  def published?
    published_at <= DateTime.now
  end

  private

  def update_media!
    self.media = find_all_associated_media
  end

  def find_all_associated_media
    find_media_from_body << self.featured_media
  end

  def find_media_from_body
    document = Nokogiri::HTML::Document.parse(body)
    media_ids = document.xpath('//@data-media-id').map{|element| element.to_s }
    Media.find(media_ids)
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
