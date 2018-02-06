Bundler.require(:default, Rails.env)

namespace :content_types do
  desc 'Re-Seeds (will wipe existing ContentTypes!) CortexStarter with Core Custom Content Seed Data'
  task reseed: :environment do
    Rake::Task['content_types:clear'].execute
    Rake::Task['content_types:seed'].execute
  end

  desc 'Seeds CortexStarter with Core Custom Content Seed Data'
  task seed: :environment do
    Rake::Task['cortex:core:media:seed'].execute
    Rake::Task['employer:blog:seed'].execute
  end

  desc 'Clear Existing Custom Content Data From DB'
  task clear: :environment do
    puts "Clearing ContentTypes..."
    Cortex::ContentType.destroy_all
    puts "Clearing Fields..."
    Cortex::Field.destroy_all
    puts "Clearing ContentItems..."
    Cortex::ContentItem.destroy_all
    puts "Clearing FieldItems..."
    Cortex::FieldItem.destroy_all
    puts "Clearing ContentableDecorators..."
    Cortex::ContentableDecorator.destroy_all
    puts "Clearing Decorators..."
    Cortex::Decorator.destroy_all
  end
end
