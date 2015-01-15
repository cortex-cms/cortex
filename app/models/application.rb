class Application < ActiveRecord::Base
  has_many :credentials, class_name: 'Doorkeeper::Application', as: :owner
  belongs_to :tenant
  validates_presence_of :tenant, :name
end
