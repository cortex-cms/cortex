class Decorator < ActiveRecord::Base
  belongs_to :viewable, polymorphic: true

  validates :decorator_type, :decorator_data, :viewable_type, :viewable_id, presence: true
  validate :view_type_is_allowed

  def view_type_is_allowed
    unless ["Index", "Form Wizard"].include?(decorator_type)
      errors.add(:decorator_type, "must be an allowed type.")
    end
  end
end
