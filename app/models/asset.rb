class Asset < ActiveRecord::Base
  belongs_to :user
  has_attached_file :file, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates_attachment :file,
	  :content_type => { :content_type => "image/jpg", :content_type => "image/png" },
	  :size => { :in => 0..10.megabytes }
end
