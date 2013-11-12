Apartment.configure do |config|
    config.excluded_models = ['Organization', 'PlatformAdmin']
    config.database_names = lambda{ Organization.pluck(:name) }
end