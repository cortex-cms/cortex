class LocalizationService
  include LocaleService

  def initialize(id)
    @id = id
    @jargon_id = ::Localization.find_by_id(id).jargon_id
  end

  def all
    rejects_id!
    merge_localizations(::Localization.all, jargon.localizations.query)
  end

  def get
    expects_id!
    cortex_localization = ::Localization.find_by_id(id)
    jargon_localization = jargon.localizations(jargon_id).get

    merge_localization(cortex_localization, jargon_localization)
  end

  def delete
    expects_id!
    jargon_localization = jargon.localizations(jargon_id).delete
    if jargon_localization.is_error?
      throw Exception.new(jargon_localization)
    else
      cortex_localization = ::Localization.destroy(id)

      cortex_localization
    end
  end

  def create(body)
    jargon_localization = jargon.localizations.save(body)
    if jargon_localization.is_error?
      throw Exception.new(jargon_localization)
    else
      cortex_localization = ::Localization.new(body)
      cortex_localization.user = current_user!
      cortex_localization.save!

      cortex_localization
    end
  end

  def update(body)
    jargon_localization = jargon.localizations.save(body)
    if jargon_localization.is_error?
      throw Exception.new(jargon_localization)
    else
      cortex_localization = ::Localization.update!(body)
      cortex_localization.save!

      cortex_localization
    end
  end

  protected
  attr_accessor :id, :jargon_id
end
