class LocalizationService
  include ::LocaleService

  def initialize(current_user, id=nil)
    @id = id
    @jargon_id = id ? ::Localization.find_by_id(id).jargon_id : nil

    #TODO: Emergency! ELIMINATE this cross-cutting concern by abstracting authorization to central lib. Absolutely critical.
    @current_user = current_user
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
      cortex_localization = ::Localization.new
      cortex_localization.jargon_id = jargon_localization.id
      cortex_localization.user = @current_user
      cortex_localization.save!

      cortex_localization
    end
  end

  def update(body)
    jargon_localization = jargon.localizations.save(body)
    if jargon_localization.is_error?
      throw Exception.new(jargon_localization)
    end

    ::Localization.find_by_id(body.id)
  end

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
      jargon_localization = jargon_localizations.select { |jargon_localization| jargon_localization.id == cortex_localization.jargon_id }.first
      merge_localization(cortex_localization, jargon_localization)
    }
  end

  def merge_localization(cortex_localization, jargon_localization)
    jargon_localization.id = cortex_localization.id
    jargon_localization.user = cortex_localization.user
    jargon_localization.locales = merge_locales(cortex_localization.locales, jargon_localization.locales)

    jargon_localization
  end

  def merge_locales(cortex_locales, jargon_locales)
    jargon_locales.map { |jargon_locale|
      cortex_locale = cortex_locales.select { |cortex_locale| cortex_locale.name == jargon_locale.name }.first
      merge_locale(cortex_locale, jargon_locale)
    }
  end

  def merge_locale(cortex_locale, jargon_locale)
    jargon_locale.id = cortex_locale.id
    jargon_locale.user = cortex_locale.user

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

  protected
  attr_accessor :id, :jargon_id
end
