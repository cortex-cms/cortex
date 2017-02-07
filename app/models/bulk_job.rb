class BulkJob < ApplicationRecord
  belongs_to :user

  serialize :log

  has_attached_file :metadata
  has_attached_file :assets

  # Restore content type validation for :metadata once Rails/Paperclip fixes downloaded CSVs (from S3) content type showing as 'application/force-download'
  validates_attachment :metadata, :presence => true
  validates_attachment_content_type :assets, :content_type => ['application/zip']
  validates_presence_of :content_type
  validates_presence_of :user
end
