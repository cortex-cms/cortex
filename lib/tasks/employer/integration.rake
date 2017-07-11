Bundler.require(:default, Rails.env)

namespace :employer do
  namespace :integration do
    desc 'Seed Employer Integration ContentType and Fields'
    task seed: :environment do
      def category_tree
        tree = Tree.new
        tree.add_node({ name: "Category 1" })
        tree.add_node({ name: "Category 2" })
        tree.add_node({ name: "Category 3" })
        tree
      end

      puts 'Creating Employer Integration ContentType...'
      integration = ContentType.new({
                               name: "Employer Integration",
                               description: "3rd Party CareerBuilder Integrations",
                               icon: "device hub",
                               creator_id: 1,
                               contract_id: 1,
                               publishable: true
                             })
      integration.save!

      puts "Creating Fields..."
      integration.fields.new(name: 'Body', field_type: 'text_field_type', metadata: {parse_widgets: true}, validations: { presence: true })
      integration.fields.new(name: 'Title', field_type: 'text_field_type', validations: {presence: true})
      integration.fields.new(name: 'Description', field_type: 'text_field_type', validations: {presence: true})
      integration.fields.new(name: 'Slug', field_type: 'text_field_type', validations: {presence: true, uniqueness: true})
      integration.fields.new(name: 'Tags', field_type: 'tag_field_type')
      integration.fields.new(name: 'Publish Date', field_type: 'date_time_field_type', metadata: {state: 'Published'})
      integration.fields.new(name: 'Expiration Date', field_type: 'date_time_field_type', metadata: {state: 'Expired'})
      integration.fields.new(name: 'SEO Title', field_type: 'text_field_type', validations: {presence: true, uniqueness: true })
      integration.fields.new(name: 'SEO Description', field_type: 'text_field_type', validations: {presence: true})
      integration.fields.new(name: 'SEO Keywords', field_type: 'tag_field_type')
      integration.fields.new(name: 'No Index', field_type: 'boolean_field_type')
      integration.fields.new(name: 'No Follow', field_type: 'boolean_field_type')
      integration.fields.new(name: 'No Snippet', field_type: 'boolean_field_type')
      integration.fields.new(name: 'No ODP', field_type: 'boolean_field_type')
      integration.fields.new(name: 'No Archive', field_type: 'boolean_field_type')
      integration.fields.new(name: 'No Image Index', field_type: 'boolean_field_type')
      integration.fields.new(name: 'Categories', field_type: 'tree_field_type', metadata: {allowed_values: category_tree})
      integration.fields.new(name: 'Featured Image', field_type: 'content_item_field_type',
                      metadata: {
                        field_name: 'Asset'
                      })

      puts "Saving Employer Integration..."
      integration.save!

      puts "Creating Wizard Decorators..."
      wizard_hash = {
        "steps": [
          {
            "name": "Write",
            "columns": [
              {
                "grid_width": 12,
                "elements": [
                  {
                    "id": integration.fields.find_by_name('Title').id
                  },
                  {
                    "id": integration.fields.find_by_name('Body').id,
                    "render_method": "wysiwyg",
                    "input": {
                      "display": {
                        "styles": {
                          "height": "500px"
                        }
                      }
                    }
                  }
                ]
              }
            ]
          },

          {
            "name": "Details",
            "columns": [
              {
                "grid_width": 6,
                "elements": [
                  {
                    "id": integration.fields.find_by_name('Description').id,
                    "tooltip": 'This is a short description and will be used as the preview text for an employer before they click into the integration.'
                  },
                  {
                    "id": integration.fields.find_by_name('Publish Date').id
                  },
                  {
                    "id": integration.fields.find_by_name('Expiration Date').id
                  }
                ]
              },
              {
                "grid_width": 6,
                "elements": [
                  {
                    "id": integration.fields.find_by_name('Tags').id
                  },
                  {
                    "id": integration.fields.find_by_name('Slug').id,
                    "tooltip": "This is your integrations's URL. Between each word, place a hyphen. Best if between 35-50 characters and don't include years/dates."
                  }
                ]
              }
            ]
          },
          {
            "name": "Categorize",
            "columns": [
              {
                "grid_width": 4,
                "elements": [
                  {
                    "id": integration.fields.find_by_name('Categories').id,
                    "render_method": "checkboxes"
                  }
                ]
              },
              {
                "grid_width": 8,
                "elements": [
                  {
                    "id": integration.fields.find_by_name('Featured Image').id,
                    "render_method": "popup"
                  }
                ]
              }
            ]
          },
          {
            "name": "Search",
            "columns": [
              {
                "grid_width": 6,
                "elements": [
                  {
                    "id": integration.fields.find_by_name('SEO Title').id,
                    "tooltip": 'Please use <70 characters for your SEO title for optimal appearance in search results.'
                  },
                  {
                    "id": integration.fields.find_by_name('SEO Description').id,
                    "tooltip": 'The description should optimally be between 150-160 characters and keyword rich.'
                  },
                  {
                    "id": integration.fields.find_by_name('SEO Keywords').id,
                    "tooltip": 'Utilize the recommended keywords as tags to boost your SEO performance.'
                  }
                ]
              },
              {
                "grid_width": 6,
                "description": "Select these if you don't want your integration to be indexed by search engines like Google",
                "elements": [
                  {
                    "id": integration.fields.find_by_name('No Index').id
                  },
                  {
                    "id": integration.fields.find_by_name('No Follow').id
                  },
                  {
                    "id": integration.fields.find_by_name('No Snippet').id
                  },
                  {
                    "id": integration.fields.find_by_name('No ODP').id
                  },
                  {
                    "id": integration.fields.find_by_name('No Archive').id
                  },
                  {
                    "id": integration.fields.find_by_name('No Image Index').id
                  }
                ]
              }
            ]
          }
        ]
      }

      wizard_decorator = Decorator.new(name: "Wizard", data: wizard_hash)
      wizard_decorator.save!

      ContentableDecorator.create!({
                                    decorator_id: wizard_decorator.id,
                                    contentable_id: integration.id,
                                    contentable_type: 'ContentType'
                                  })

      puts "Creating Index Decorators..."
      index_hash = {
        "columns":
          [
            {
              "name": "Title",
              "grid_width": 3,
              "cells": [{
                          "field": {
                            "id": integration.fields.find_by_name('Title').id
                          }
                        }]
            },
            {
              "name": "Integration Details",
              "cells": [
                {
                  "field": {
                    "id": integration.fields.find_by_name('Description').id
                  },
                  "display": {
                    "classes": [
                      "bold",
                      "upcase"
                    ]
                  }
                },
                {
                  "field": {
                    "id": integration.fields.find_by_name('Slug').id
                  }
                },
                {
                  "field": {
                    "method": "publish_state"
                  }
                }
              ]
            },
            {
              "name": "Tags",
              "cells": [
                {
                  "field": {
                    "id": integration.fields.find_by_name('Tags').id
                  },
                  "display": {
                    "classes": [
                      "tag",
                      "rounded"
                    ]
                  }
                }
              ]
            }
          ]
      }

      index_decorator = Decorator.new(name: "Index", data: index_hash)
      index_decorator.save!

      ContentableDecorator.create!({
                                    decorator_id: index_decorator.id,
                                    contentable_id: integration.id,
                                    contentable_type: 'ContentType'
                                  })
    end
  end
end
