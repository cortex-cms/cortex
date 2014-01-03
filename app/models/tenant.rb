class Tenant < ActiveRecord::Base
  default_scope where(deleted_at: nil)
  acts_as_nested_set
  acts_as_paranoid
  after_initialize :init

  belongs_to :user
  has_and_belongs_to_many :posts

  validates_presence_of :name
  validates_associated :user

  def is_organization?
    parent_id == nil
  end

  def init
    self.subdomain ||= name.mb_chars.normalize(:kd).downcase.gsub(/[^a-z0-9]/, '').to_s
  end
end

# == Schema Information
#
# Table name: tenants
#
#  id            :integer          not null, primary key
#  name          :string(50)       not null
#  subdomain     :string(50)
#  parent_id     :integer
#  lft           :integer
#  rgt           :integer
#  depth         :integer
#  contact_name  :string(50)
#  contact_email :string(200)
#  contact_phone :string(20)
#  deleted_at    :datetime
#  contract      :string(255)
#  did           :string(255)
#  active_at     :datetime
#  deactive_at   :datetime
#  created_by    :integer          not null
#  created_at    :datetime
#  updated_at    :datetime
#
