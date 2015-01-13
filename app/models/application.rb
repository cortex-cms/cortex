class Application < ActiveRecord::Base
  has_many :oauth_applications, class_name: 'Doorkeeper::Application', as: :owner
  belongs_to :tenant
  validates_presence_of :tenant
end
