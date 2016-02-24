class Webpage < ActiveRecord::Base
  include FindByTenant
  include SearchableWebpage

  acts_as_paranoid

  belongs_to :user
  has_many :snippets, inverse_of: :webpage
  has_many :documents, through: :snippets, :dependent => :destroy

  accepts_nested_attributes_for :snippets
end
