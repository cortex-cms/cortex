class Webpage < ActiveRecord::Base
  include FindByTenant
  include SearchableWebpage

  scope :find_by_protocol_agnostic_url, ->(suffix) { where('url LIKE :suffix', query: "%#{suffix}") }

  acts_as_paranoid
  acts_as_taggable_on :seo_keywords

  belongs_to :user
  has_many :snippets, inverse_of: :webpage
  has_many :documents, through: :snippets, :dependent => :destroy

  accepts_nested_attributes_for :snippets
end
