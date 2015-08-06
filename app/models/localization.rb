class Localization < ActiveRecord::Base
  has_many :locales, dependent: :destroy
  belongs_to :user

  accepts_nested_attributes_for :locales

  validates :name, presence: true, uniqueness: true

  def list_locales
    locales.inject([]) { |memo, enum| memo << enum.name }
  end

  def retrieve_locale(locale_name)
    locales.find { |locale| locale.name == locale_name }
  end

  alias_method :available_locales, :list_locales
end
