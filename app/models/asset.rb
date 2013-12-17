class Asset < ActiveRecord::Base
  acts_as_taggable

  belongs_to :user
  has_and_belongs_to_many :posts
  has_attached_file :attachment, :styles => { :medium => '300x300>', :thumb => '100x100>' }
  before_save :extract_dimensions
  serialize :dimensions

  validates_attachment :attachment, :presence => true,
  	:content_type => { :content_type => [
    	'image/jpeg',
      'image/jpg',
      'image/pjpeg',
    	'image/png',
      'image/gif',
      'image/bmp',
      'image/x-png',
    	'application/pdf',
    	'application/vnd.ms-excel',
    	'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    	'application/msword',
    	'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    	'text/plain',
    	'image/gif',
    	'application/zip',
    	'video/x-msvideo',
    	'video/quicktime',
    	'video/mp4']
	  },
    :size => { :in => 0..100.megabytes }

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
