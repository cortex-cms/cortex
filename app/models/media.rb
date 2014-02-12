require 'digest/sha1'
require 'mime/types'

class Media < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
  include Taxon

  acts_as_taggable
  acts_as_paranoid

  belongs_to :user
  has_and_belongs_to_many :posts

  default_scope { order('created_at DESC')  }

  serialize :dimensions
  before_save :extract_dimensions
  before_save :generate_digest

  has_attached_file :attachment, :styles => {
      :large => {geometry: '800x800>', format: :png},
      :default => {geometry: '300x300>', format: :png},
      :mini => {geometry: '100x100>', format: :png},
      :micro => {geometry: '50x50>', format: :png}
  }

  before_attachment_post_process :can_thumb

  validates_attachment :attachment, :presence => true,
                       :content_type => {:content_type => AppSettings.media.allowed_media_types.collect{|allowed| allowed[:type]}},
                       :size => {:in => 0..AppSettings.media.max_size_mb.megabytes}


  settings :analysis => {
      :analyzer => {
          :taxon_analyzer => {
              :type => 'custom',
              :tokenizer => 'standard',
              :filter => %w(standard lowercase ngram)
          }
      }
  } do
    mapping do
      indexes :id, :index => :not_analyzed
      indexes :name, :analyzer => :snowball, :boost => 100.0
      indexes :created_by, :analyzer => :keyword, :as => 'user.email'
      indexes :file_name, :analyzer => :keyword
      indexes :description, :analyzer => :snowball
      indexes :tags, :analyzer => :keyword, :as => 'tag_list'
      indexes :created_at, :type => :date, :include_in_all => false
      indexes :taxon, :analyzer => :taxon_analyzer, :as => 'create_taxon'
    end
  end

  # This will indicate whether an asset is associated with another
  def consumed?
    return false
  end

  # 'Human friendly' content type generalization
  def general_type
    if (attachment_content_type =~ /(excel)|(spreadsheet)/) != nil
      'spreadsheet'
    elsif (attachment_content_type =~ /(^application\/vnd\.)|(^application\/msword)/) != nil
      'doc'
    elsif attachment_content_type =~ /pdf/
      'pdf'
    elsif attachment_content_type =~ /zip/
      'archive'
    else
      attachment_content_type.match(/(\w+)\//)[1]
    end
  end

  class << self
    remove_method :index
  end

  def can_thumb
    AppSettings.media.allowed_media_types.select{|allowed| allowed[:thumb] && allowed[:type] == attachment_content_type} != []
  end

  private

  def image?
    attachment_content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png)$}
  end

  def taxon_type
    AppSettings.media.allowed_media_types.select{|t| t[:type] == attachment_content_type}[0][:taxon_type]
  end

  def extract_dimensions
    return unless image?
    tempfile = attachment.queued_for_write[:original]
    unless tempfile.nil?
      geometry = Paperclip::Geometry.from_file(tempfile)
      self.dimensions = [geometry.width.to_i, geometry.height.to_i]
    end
  end

  def generate_digest
    tempfile = attachment.queued_for_write[:original]
    unless tempfile.nil?
      self.digest = Digest::SHA1.file(tempfile.path).to_s
    end
  end
end

# == Schema Information
#
# Table name: assets
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  user_id                 :integer
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#  dimensions              :string(255)
#  description             :text
#  alt                     :string(255)
#  active                  :boolean
#  deactive_at             :datetime
#  created_at              :datetime
#  updated_at              :datetime
#  digest                  :string(255)      not null
#  deleted_at              :datetime
#
