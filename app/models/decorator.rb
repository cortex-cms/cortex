class Decorator < ActiveRecord::Base
  has_many :contentable_decorators

  validates :type, :data, presence: true
  validate :type_is_allowed

  def type_is_allowed
    unless ["Index", "Form Wizard"].include?(type)
      errors.add(:type, "must be an allowed type.")
    end
  end
end
