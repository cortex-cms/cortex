class Document < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user
  has_many :webpages, through: :webpage_documents

  has_attached_file :thumbnail, styles: {tile: '150x150>'}
end
