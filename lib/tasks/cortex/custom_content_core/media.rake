Bundler.require(:default, Rails.env)

namespace :cortex do
  namespace :custom_content_core do
    namespace :media do
      desc 'Seed Cortex Media ContentType and Fields'
      task seed: :environment do
        puts "Creating Media ContentType..."
        media = ContentType.new({
          name: "Media",
          description: "Media for Cortex",
          icon: "collections",
          creator_id: 1,
          contract_id: 1
        })
        media.save

        puts "Creating Fields..."
        media.fields.new(name: 'Title', field_type: 'text_field_type', order_position: 1, validations: { presence: true })
        media.fields.new(name: 'Description', field_type: 'text_field_type', order_position: 2, validations: { presence: true })
        media.fields.new(name: 'Tags', field_type: 'tag_field_type', order_position: 3, validations: {})
        media.fields.new(name: 'Expiration Date', field_type: 'date_time_field_type', order_position: 4, validations: {})
        media.fields.new(name: 'Alt Tag', field_type: 'text_field_type', order_position: 5, validations: {})
        media.save

        puts "Creating Wizard Decorators..."
        wizard_hash = {
          "steps": [
            {
              "name": "Upload",
              "heading": "First thing's first..",
              "description": "Add your media asset.",
              "columns": [
                {
                  "grid_width": 12,
                  "fields": []
                }
              ]
            },
            {
              "name": "Metadata",
              "heading": "Let's talk about your asset..",
              "description": "Provide details and metadata that will enhance search or inform end-users.",
              "columns": [
                {
                  "grid_width": 12,
                  "fields": [
                    {
                      "id": media.fields[0].id
                    },
                    {
                      "id": media.fields[1].id
                    },
                    {
                      "id": media.fields[2].id
                    },
                    {
                      "id": media.fields[3].id
                    },
                    {
                      "id": media.fields[4].id
                    }
                  ]
                }
              ]
            }
          ]
        }

        media_wizard_decorator = Decorator.new(name: "Wizard", data: wizard_hash)
        media_wizard_decorator.save

        ContentableDecorator.create({
          decorator_id: media_wizard_decorator.id,
          contentable_id: media.id,
          contentable_type: 'ContentType'
        })

        puts "Creating Index Decorators..."
        index_hash = {
        "columns":
          [
            {
              "name": "Thumbnail",
              "cells": [{
                "field": {
                  "method": "author_image"
                },
                "display": {
                  "classes": [
                    "circular"
                  ]
                }
              }]
            },
            {
              "name": "Creator",
              "cells": [{
                "field": {
                  "method": "author_image"
                },
                "display": {
                  "classes": [
                    "circular"
                  ]
                }
              }]
            },
            {
              "name": "Details",
              "cells": [
                {
                  "field": {
                    "id": media.fields[0].id
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
                    "id": media.fields[1].id
                  }
                }
              ]
            },
            {
              "name": "Tags",
              "cells": [
                {
                  "field": {
                    "id": media.fields[2].id
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

        media_index_decorator = Decorator.new(name: "Index", data: index_hash)
        media_index_decorator.save

        ContentableDecorator.create({
          decorator_id: media_index_decorator.id,
          contentable_id: media.id,
          contentable_type: 'ContentType'
        })
      end
    end
  end
end
