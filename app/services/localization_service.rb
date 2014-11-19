class LocalizationService
  def all
    jargon.localizations.query
  end

  def get(id)
    localization_cortex = ::Localization.find_by_id(id)
    localization_jargon = jargon.localizations(localization_cortex.jargon_id).get

    localization_cortex.merge(localization_jargon)
  end

  def delete(id)
    jargon_localization = jargon.localizations(id).delete
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

  private

  def merge_all(cortex_results, jargon_results)
    cortex_results.map { |cortex_localization|
      jargon_localization = jargon_results.select { |jargon_localization| jargon_localization.id == cortex_localization.jargon_id }.first
      merge_localization(cortex_localization, jargon_localization)
    }
  end

  def merge_localization(cortex_localization, jargon_localization)
    jargon_localization.id = cortex_localization.id
    jargon_localization.user = cortex_localization.user
    jargon_localization.locales = jargon_localization.locales.map { |jargon_locale|
      cortex_locale = cortex_localization.select { |cortex_locale| cortex_locale.jargon_id == jargon_locale.id }.first
      merge_locale(cortex_locale, jargon_locale)
    }

    jargon_localization
  end

  def merge_locale(cortex_locale, jargon_locale)
    jargon_locale.id = cortex_locale.id
    jargon_locale.user = cortex_locale.user

    jargon_locale
  end
end
