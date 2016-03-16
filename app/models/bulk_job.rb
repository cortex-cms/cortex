class BulkJob < ActiveRecord::Base
  belongs_to :user

  serialize :log

  has_attached_file :metadata
  has_attached_file :assets

  # Restore content type validation once Rails/Paperclip fixes downloaded CSVs (from S3) content type showing as 'application/force-download'
  validates_attachment :metadata, :presence => true
  # TODO: This is currently broken when used in conjunction with S3. Revisit this at a later date.
  # validates_with AttachmentContentTypeValidator, :attributes => :assets, :content_type => 'application/zip'
  validates_presence_of :content_type
end
