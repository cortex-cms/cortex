Apartment.configure do |config|
    config.excluded_models = ['Tenant', 'Asset', 'Post', 'Category', 'CategoriesPost', 'AssetsPost']
    config.database_names = lambda{ Tenant.roots.pluck(:subdomain) }
end