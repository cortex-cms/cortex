class Asset < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable
  has_attached_file :attachment, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates_attachment :attachment, :presence => true,
  	:content_type => {
    	:content_type => "image/jpeg",
    	:content_type => "image/png",
    	:content_type => "application/pdf",
    	:content_type => "application/vnd.ms-excel",
    	:content_type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    	:content_type => "application/msword",
    	:content_type => "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    	:content_type => "text/plain",
    	:content_type => "image/gif",
    	:content_type => "application/zip",
    	:content_type => "video/x-msvideo",
    	:content_type => "video/quicktime",
    	:content_type => "video/mp4"
	},
    :size => { :in => 0..10.megabytes } 
end
