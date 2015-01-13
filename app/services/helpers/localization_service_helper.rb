module LocalizationServiceHelper
  private

  def jargon
    @jargon ||= Jargon::Client.new(key: Cortex.config.jargon.client_id,
                                   secret: Cortex.config.jargon.client_secret,
                                   base_url: Cortex.config.jargon.site_url,
                                   username: Cortex.config.jargon.username,
                                   password: Cortex.config.jargon.password)
  end

  def merge_localizations(cortex_localizations, jargon_localizations)
    cortex_localizations.map { |cortex_localization|
      jargon_localization = jargon_localizations.select { |jargon_localization| jargon_localization[:id] == cortex_localization.jargon_id }.first
      merge_localization(cortex_localization, jargon_localization)
    }
  end

  def merge_localization(cortex_localization, jargon_localization)
    jargon_localization[:id] = cortex_localization.id
    jargon_localization[:user] = cortex_localization.user
    jargon_localization[:created_at] = cortex_localization.created_at
    jargon_localization[:updated_at] = cortex_localization.updated_at
    jargon_localization[:locales] = merge_locales(cortex_localization.locales, jargon_localization[:locales])

    jargon_localization
  end

  def merge_locales(cortex_locales, jargon_locales)
    jargon_locales.map { |jargon_locale|
      cortex_locale = cortex_locales.select { |cortex_locale| cortex_locale.name == jargon_locale[:name] }.first
      merge_locale(cortex_locale, jargon_locale)
    }
  end

  def merge_locale(cortex_locale, jargon_locale)
    jargon_locale[:id] = cortex_locale.id
    jargon_locale[:user] = cortex_locale.user
    jargon_locale[:created_at] = cortex_locale.created_at
    jargon_locale[:updated_at] = cortex_locale.updated_at

    jargon_locale
  end

  def expects_id!
    if !id
      raise Cortex::Exceptions::IdExpected
    end
  end

  def rejects_id!
    if id
      raise Cortex::Exceptions::IdNotExpected
    end
  end
end