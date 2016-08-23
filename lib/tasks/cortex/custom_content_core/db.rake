Bundler.require(:default, Rails.env)

namespace :cortex do
  namespace :custom_content_core do
    namespace :db do
      desc 'Seeds Cortex with Core Custom Content Seed Data'
      task reseed: :environment do
        Rake::Task['cortex:custom_content_core:db:clear'].execute
        Rake::Task['employer:blog:seed'].execute
      end

      desc 'Clear Existing Custom Content Data From DB'
      task clear: :environment do
        puts "Clearing ContentTypes..."
        ContentType.destroy_all
        puts "Clearing Fields..."
        Field.destroy_all
        puts "Clearing ContentItems..."
        ContentItem.destroy_all
        puts "Clearing FieldItems..."
        FieldItem.destroy_all
        puts "Clearing ContentableDecorators..."
        ContentableDecorator.destroy_all
        puts "Clearing Decorators..."
        Decorator.destroy_all
      end
    end
  end
end
