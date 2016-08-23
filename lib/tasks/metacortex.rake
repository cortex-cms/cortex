namespace :metacortex do
  namespace :db do
    task setup: :environment do
      desc 'Sets up Metacortex with Seed Data'

      unless Rails.env.production?
        system( 'rake metacortex:db:clear' )
        system( 'rake metacortex:employer_blog:seed' )
      end
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
