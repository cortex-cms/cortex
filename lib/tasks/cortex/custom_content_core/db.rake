namespace :cortex do
  namespace :custom_content_core do
    namespace :db do
      task reseed: :environment do
        desc 'Sets up Metacortex with Seed Data'

        Rake::Task['cortex:custom_content_core:db:clear'].execute
        Rake::Task['cortex:employer:blog:seed'].execute
      end

      task clear: :environment do
        desc 'Clear Custom Content From DB'

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
