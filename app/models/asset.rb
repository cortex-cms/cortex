class Asset < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::AsyncCallbacks
  acts_as_taggable

  belongs_to :user

  has_many :assets_posts
  has_many :posts, through: :assets_posts
  has_attached_file :attachment, :styles => { :medium => '300x300>', :thumb => '100x100>' }
  serialize :dimensions

  before_save   :extract_dimensions

  validates_attachment :attachment, :presence => true,
  	:content_type => { :content_type => %w(
    	image/jpeg
      image/jpg
      image/pjpeg
    	image/png
      image/gif
      image/bmp
      image/x-png
    	application/pdf
    	application/vnd.ms-excel
    	application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
    	application/msword
    	application/vnd.openxmlformats-officedocument.wordprocessingml.document
    	text/plain
    	image/gif
    	application/zip
    	video/x-msvideo
    	video/quicktime
    	video/mp4)
	  },
    :size => { :in => 0..100.megabytes }

  mapping do
    indexes :id,          :index => :not_analyzed
    indexes :name,        :analyzer => :snowball, :boost => 2.0
    indexes :created_by,  :analyzer => :keyword, :as => 'user.name'
    indexes :file_name,   :analyzer => :keyword
    indexes :description, :analyzer => :snowball
    indexes :tags,        :analyzer => :keyword, :as => 'tag_list'
    indexes :created_at,  :type => :date, :include_in_all => false
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
