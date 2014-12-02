class Locale < ActiveRecord::Base
  belongs_to :user, :localizations
  validates_uniqueness_of :locale, scope: :localization_id
end
