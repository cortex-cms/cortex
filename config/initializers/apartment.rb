Apartment.configure do |config|
    config.excluded_models = ['Tenant', 'Post', 'Category', 'Asset']
    config.database_names = lambda{ Tenant.roots.pluck(:subdomain) }
end