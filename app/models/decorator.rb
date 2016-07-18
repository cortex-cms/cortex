class Decorator < ActiveRecord::Base
  has_many :content_decorators

  validates :type, :data, presence: true
  validate :view_type_is_allowed

  def type_is_allowed
    unless ["Index", "Form Wizard"].include?(type)
      errors.add(:type, "must be an allowed type.")
    end
  end
end
