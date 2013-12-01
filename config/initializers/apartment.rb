Apartment.configure do |config|
    config.excluded_models = ['Tenant']
    config.database_names = lambda{ Tenant.roots.pluck(:subdomain) }
end