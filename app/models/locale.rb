class Locale < ActiveRecord::Base
  belongs_to :user
  belongs_to :localizations

  validates_uniqueness_of :name, scope: :localization_id
end
