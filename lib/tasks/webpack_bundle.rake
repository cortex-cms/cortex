namespace :webpack do
  desc 'Ensures Webpack bundle is compiled'
  task ensure_assets_compiled: :environment do
    ReactOnRails::TestHelper.ensure_assets_compiled
  end
end
