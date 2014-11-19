class Locale < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user, :localizations
end
