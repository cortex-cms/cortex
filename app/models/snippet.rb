class Snippet < ActiveRecord::Base
  include FindByTenant
  
  acts_as_paranoid

  belongs_to :user
  belongs_to :webpage
  belongs_to :document

  accepts_nested_attributes_for :document
end
