require_relative 'helpers/localization_service_helper'

class LocalizationService
  include ::LocalizationServiceHelper
  include ::LocaleService

  def initialize(current_user, id=nil)
    @id = id
    @jargon_id = id ? ::Localization.find_by_id(id).jargon_id : nil

    #TODO: Emergency! ELIMINATE this cross-cutting concern by abstracting authorization to central lib. Absolutely critical.
    @current_user = current_user
  end

  def all
    rejects_id!
    cortex_localizations = ::Localization.all
    jargon_localizations = jargon.localizations.query
    if jargon_localizations.is_error?
      throw Exception.new(jargon_localizations)
    else
      merge_localizations(cortex_localizations, jargon_localizations.contents[:localizations])
    end
  end

  def get
    expects_id!
    cortex_localization = ::Localization.find_by_id(id)
    if cortex_localization
      jargon_localization = jargon.localizations(jargon_id).get
      if jargon_localization.is_error?
        throw Exception.new(jargon_localization)
      else
        merge_localization(cortex_localization, jargon_localization.contents[:localization])
      end
    else
      throw ActiveRecord::RecordNotFound
    end
  end

  def delete
    expects_id!
    cortex_localization = ::Localization.find_by_id(id)
    cortex_localization.destroy!
    jargon_localization = jargon.localizations(jargon_id).delete
    if jargon_localization.is_error?
      throw Exception.new(jargon_localization)
    else
      merge_localization(cortex_localization, jargon_localization.contents[:localization])
    end
  end

  def create(body)
    jargon_localization = jargon.localizations.save(body)
    if jargon_localization.is_error?
      throw Exception.new(jargon_localization)
    else
      cortex_localization = ::Localization.new
      cortex_localization.jargon_id = jargon_localization.contents[:localization][:id]
      cortex_localization.user = @current_user
      cortex_localization.save!

      merge_localization(cortex_localization, jargon_localization.contents[:localization])
    end
  end

  def update(body)
    cortex_localization = ::Localization.find_by_id(body[:id])

    body[:id] = cortex_localization.jargon_id
    jargon_localization = jargon.localizations.save(body)
    if jargon_localization.is_error?
      throw Exception.new(jargon_localization)
    end

    merge_localization(cortex_localization, jargon_localization.contents[:localization])
  end

  protected
  attr_accessor :id, :jargon_id
end
