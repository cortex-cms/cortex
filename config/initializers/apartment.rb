Apartment.configure do |config|
    config.excluded_models = ['Tenant', 'Asset']
    config.database_names = lambda{ Tenant.roots.pluck(:subdomain) }
end