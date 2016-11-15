module PaperclipExtensions
  module Attachment
    def arbitrary_url_for(pattern, style_name = :original)
      Paperclip::Interpolations.interpolate pattern, self, style_name
    end
  end
end

class Media < ApplicationRecord
  include SearchableMedia
  include Taxon
  include FindByTenant

  acts_as_taggable
  acts_as_paranoid

  belongs_to :user
  has_and_belongs_to_many :posts

  default_scope { order('created_at DESC') }

  scope :consumed, lambda { joins(:posts).where('posts.id is not null') }

  serialize :dimensions

  has_attached_file :attachment,
                    :styles => {
                      :large => {geometry: '1800x1800>', format: :jpg},
                      :medium => {geometry: '800x800>', format: :jpg},
                      :default => {geometry: '300x300>', format: :jpg},
                      :mini => {geometry: '100x100>', format: :jpg},
                      :micro => {geometry: '50x50>', format: :jpg},
                      :ar_post => {geometry: '1140x', format: :jpg}
                    },
                    :processors => [:thumbnail, :paperclip_optimizer],
                    :preserve_files => 'true',
                    # :path => ':class/:attachment/:style-:id.:extension'
                    :path => ':class/:attachment/careerbuilder-:style-:id.:extension',
                    :s3_headers => { 'Cache-Control' => 'public, max-age=315576000' }

  validates_attachment :attachment,
                       :presence => true,
                       :unless => :skip_attachment_validation,
                       :content_type => {:content_type => Cortex.config.media.allowed_media_types.to_a.collect { |allowed| allowed[:type] }},
                       :size => {:in => 0..Cortex.config.media.max_size_mb.to_i.megabytes}

  validates :type, inclusion: {in: %w(Media Youtube)}

  Paperclip::Attachment.include PaperclipExtensions::Attachment

  def consumed?
    Media.consumed.include?(self)
  end

  # Human friendly content type generalization
  def content_type
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

  def url
    attachment.url
  end

  def can_thumb?
    Cortex.config.media.allowed_media_types.to_a.select { |allowed| allowed[:thumb] && allowed[:type] == attachment_content_type } != []
  end

  def skip_attachment_validation
    false
  end

  private

  def taxon_type
    if attachment_content_type
      Cortex.config.media.allowed_media_types.to_a.find { |t| t[:type] == attachment_content_type }[:taxon_type]
    end
  end
end
