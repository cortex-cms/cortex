class Localization < ActiveRecord::Base
  has_many :locales, dependent: :destroy
  belongs_to :user

  def list_locales
    locales.inject([]) { |memo, enum| memo << enum.name }
  end

  def retrieve_locale(locale_name)
    locales.find { |locale| locale.name == locale_name }
  end
end
