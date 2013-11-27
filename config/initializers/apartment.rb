Apartment.configure do |config|
    config.excluded_models = ['Organization', 'Tenant']
    config.database_names = lambda{ Organization.pluck(:subdomain) }
end