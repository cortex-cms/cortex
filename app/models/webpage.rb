class Webpage < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user
  has_many :snippets, inverse_of: :webpage
  has_many :documents, through: :snippets, :dependent => :destroy

  has_attached_file :thumbnail, styles: {tile: '150x150>'}, processors: [:thumbnail, :paperclip_optimizer], :preserve_files => 'true'

  accepts_nested_attributes_for :snippets

  def has_thumbnail?
    thumbnail_file_name.present?
  end
end
