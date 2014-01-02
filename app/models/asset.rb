class Asset < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::AsyncCallbacks

  acts_as_taggable
  belongs_to :user
  has_many :assets_posts
  has_many :posts, through: :assets_posts

  serialize :dimensions
  before_save :extract_dimensions

  has_attached_file :attachment, :styles => {
    :large   => {geometry: '800x800>', format: :jpg},
    :default => {geometry: '300x300>', format: :jpg},
    :mini    => {geometry: '100x100>', format: :jpg},
    :micro   => {geometry: '50x50>', format: :jpg}
  }

  validates_attachment :attachment, :presence => true,
  	:content_type => { :content_type => AppSettings.assets.allowed_media_types },
    :size => { :in => 0..AppSettings.assets.max_size_mb.megabytes }

  mapping do
    indexes :id,          :index => :not_analyzed
    indexes :name,        :analyzer => :snowball, :boost => 2.0
    indexes :created_by,  :analyzer => :keyword, :as => 'user.name'
    indexes :file_name,   :analyzer => :keyword
    indexes :description, :analyzer => :snowball
    indexes :tags,        :analyzer => :keyword, :as => 'tag_list'
    indexes :created_at,  :type => :date, :include_in_all => false
  end

  class << self
    remove_method :index
  end

  def image?
    attachment_content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png)$}
  end

  private

  def extract_dimensions
    return unless image?
    tempfile = attachment.queued_for_write[:original]
    unless tempfile.nil?
      geometry = Paperclip::Geometry.from_file(tempfile)
      self.dimensions = [geometry.width.to_i, geometry.height.to_i]
    end
  end
end

# == Schema Information
#
# Table name: assets
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  created_by              :integer
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#  dimensions              :string(255)
#  description             :text
#  deactive_at             :datetime
#  created_at              :datetime
#  updated_at              :datetime
#
