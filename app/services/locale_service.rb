require 'ostruct'

module LocaleService
  def all_locales
    expects_id!
    jargon_locales = jargon.localizations(jargon_id).query_locales
    if jargon_locales.is_error?
      throw Exception.new(jargon_locales)
    else
      cortex_locales = ::Localization.find_by_id(id).locales

      merge_locales(cortex_locales, jargon_locales.contents[:locales])
    end
  end

  def get_locale(locale_name)
    expects_id!
    cortex_locale = ::Localization.find_by_id(id).retrieve_locale(locale_name)
    jargon_locale = jargon.localizations(jargon_id).get_locale(locale_name)
    jargon_locale.contents[:locale][:json] = YAML.dump(JSON.parse(jargon_locale.contents[:locale][:json])) # This must change, spitting out YAML here is mega-inconsistent

    merge_locale(cortex_locale, jargon_locale.contents[:locale])
  end

  def delete_locale(locale_name)
    expects_id!
    jargon_locale = jargon.localizations(jargon_id).delete_locale(locale_name)
    if jargon_locale.is_error?
      throw Exception.new(jargon_locale)
    else
      cortex_locale = ::Localization.find_by_id(id).retrieve_locale(locale_name).delete

      merge_locale(cortex_locale, jargon_locale.contents[:locale])
    end
  end

  def create_locale(body)
    expects_id!

    jargon_body = OpenStruct.new(body.clone)
    body.delete(:json)
    cortex_locale = ::Locale.new(body)
    cortex_locale.localization_id = id
    cortex_locale.user = @current_user
    cortex_locale.save!

    jargon_body[:json] = YAML.load(jargon_body[:json]).to_json
    jargon_body[:locale] = jargon_body.to_h
    jargon_locale = jargon.localizations(jargon_id).save_locale(jargon_body.to_h)
    if jargon_locale.is_error?
      raise ActiveRecord::Rollback, jargon_locale
    else
      merge_locale(cortex_locale, jargon_locale.contents[:locale])
    end
  end

  def update_locale(locale_name, body)
    expects_id!

    jargon_body = OpenStruct.new(body.clone)
    body.delete(:json)
    cortex_locale = ::Localization.find_by_id(id).retrieve_locale(locale_name)
    cortex_locale.update!(body)

    jargon_body[:json] = YAML.load(jargon_body[:json]).to_json
    jargon_body[:id] = locale_name
    jargon_body[:locale] = jargon_body.to_h
    jargon_locale = jargon.localizations(jargon_id).save_locale(jargon_body.to_h)
    if jargon_locale.is_error?
      raise ActiveRecord::Rollback, jargon_locale
    else
      merge_locale(cortex_locale, jargon_locale.contents[:locale])
    end
  end
end
