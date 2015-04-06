class BulkJob < ActiveRecord::Base
  belongs_to :user
  has_attached_file :metadata
  has_attached_file :assets
  validates_attachment :metadata, :presence => true,
                       :content_type => { :content_type => 'text/csv' }
  validates_attachment :assets, :presence => true,
                       :content_type => { :content_type => 'application/zip' }
  validates_presence_of :type

  def metadata_url
    metadata.url
  end

  def assets_url
    assets.url
  end
end
