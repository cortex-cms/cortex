class Webpage < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user
  has_many :documents, through: :webpage_documents, :dependent => :destroy
end
