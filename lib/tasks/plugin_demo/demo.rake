Bundler.require(:default, Rails.env)

namespace :plugin do
  namespace :demo do
    desc 'Seed Plugin Demo ContentType and Fields'
    task seed: :environment do
      puts "Creating Plugin Demo ContentType..."
      demo = ContentType.new({
        name: "Plugin Demo",
        description: "A Demo for Plugins in Decorators",
        icon: "grade",
        creator_id: 1,
        contract_id: 1,
        publishable: false
      })
      demo.save

      puts "Creating Fields..."
      demo.fields.new(name: 'Title', field_type: 'text_field_type', validations: { presence: true })

      puts "Saving Plugin Demo..."
      demo.save

      puts "Creating Wizard Decorators..."
      wizard_hash = {
        "steps": [
          {
            "name": "Cool Ticker",
            "heading": "Cool Marquee Ticker",
            "description": "Try Adding a Title too!",
            "columns": [
              {
                "heading": "Writing Panel Sections's Optional Heading",
                "grid_width": 12,
                "display": {
                  "classes": [
                    "text--right"
                  ]
                 },
                "elements": [
                  {
                    "plugin": {
                      "class_name": "plugins/demo/demo",
                      "render_method": "marquee",
                      "data": {
                        "field_id": demo.fields[0].id
                      },
                      "display": {
                        "id": ["random", "list", "of", "ids"]
                      }
                    }
                  },
                  {
                    "id": demo.fields[0].id,
                    "input": {
                      "display": {
                        "styles": {
                          "height": "500px"
                        }
                      }
                    }
                  },
                  {
                    "method": "test_method_thingy"
                  }
                ]
              }
            ]
          }
        ]
      }

      demo_wizard_decorator = Decorator.new(name: "Wizard", data: wizard_hash)
      demo_wizard_decorator.save

      ContentableDecorator.create({
        decorator_id: demo_wizard_decorator.id,
        contentable_id: demo.id,
        contentable_type: 'ContentType'
      })

      puts "Creating Index Decorators..."
      index_hash = {
      "columns":
        [
          {
            "name": "Cool Marquee",
            "grid_width": 10,
            "cells": [{
              "field": {
                "plugin": {
                  "class_name": "plugins/demo/demo",
                  "render_method": "marquee",
                  "data": {
                    "field_id": demo.fields[0].id
                  },
                  "display": {
                    "id": ["random", "list", "of", "ids"]
                  }
                }
              }
            }]
          }
        ]
      }

      demo_index_decorator = Decorator.new(name: "Index", data: index_hash)
      demo_index_decorator.save

      ContentableDecorator.create({
        decorator_id: demo_index_decorator.id,
        contentable_id: demo.id,
        contentable_type: 'ContentType'
      })
    end
  end
end
