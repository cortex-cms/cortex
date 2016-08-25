Bundler.require(:default, Rails.env)

namespace :employer do
  namespace :blog do
    desc 'Seed Employer Blog ContentType and Fields'
    task seed: :environment do
      puts "Creating EmployerBlog ContentType..."
      blog = ContentType.new({
        name: "EmployerBlog",
        description: "Blog for Employer",
        creator_id: 1,
        contract_id: 1
      })
      blog.save

      puts "Creating Fields..."
      blog.fields.new(name: 'Title', field_type: 'text_field_type', order_position: 1, validations: { presence: true })

      blog.fields.new(name: 'Body', field_type: 'text_field_type', order_position: 2, validations: { presence: true })

      blog.fields.new(name: 'Description', field_type: 'text_field_type', order_position: 3, validations: { presence: true })

      blog.fields.new(name: 'Slug', field_type: 'text_field_type', order_position: 4, validations: { presence: true })

      blog.fields.new(name: 'Author', field_type: 'user_field_type', order_position: 5, validations: { presence: true })

      blog.fields.new(name: 'Tags', field_type: 'tag_field_type', order_position: 6, validations: {})

      blog.fields.new(name: 'Publish Date', field_type: 'date_time_field_type', order_position: 7, validations: {})

      blog.fields.new(name: 'Expiration Date', field_type: 'date_time_field_type', order_position: 8, validations: {})

      blog.fields.new(name: 'SEO Title', field_type: 'text_field_type', order_position: 10, validations: { presence: true })

      blog.fields.new(name: 'SEO Description', field_type: 'text_field_type', order_position: 11, validations: { presence: true })

      blog.fields.new(name: 'SEO Keywords', field_type: 'tag_field_type', order_position: 12, validations: {})

      blog.fields.new(name: 'No Index', field_type: 'boolean_field_type', order_position: 13)

      blog.fields.new(name: 'No Follow', field_type: 'boolean_field_type', order_position: 14)

      blog.fields.new(name: 'No Snippet', field_type: 'boolean_field_type', order_position: 15)

      blog.fields.new(name: 'No ODP', field_type: 'boolean_field_type', order_position: 16)

      blog.fields.new(name: 'No Archive', field_type: 'boolean_field_type', order_position: 17)

      blog.fields.new(name: 'No Image Index', field_type: 'boolean_field_type', order_position: 18)

      blog.save

      puts "Creating Wizard Decorators..."
      wizard_hash = {
        "steps": [
          {
            "name": "Write",
            "heading": "First thing's first..",
            "description": "Author your post using Cortex's WYSIWYG editor.",
            "columns": [
              {
                "heading": "Writing Panel Sections's Optional Heading",
                "grid_width": 12,
                "display": {
                  "classes": [
                    "text--right"
                  ]
                },
                "fields": [
                  {
                    "id": blog.fields[0].id,
                    "label": {
                      "display": {
                        "classes": [
                          "bold",
                          "upcase"
                        ]
                      }
                    },
                    "input": {
                      "display": {
                        "classes": [
                          "red"
                        ]
                      }
                    }
                  },
                  {
                    "id": blog.fields[1].id,
                    "label": {
                      "display": {
                        "classes": [
                          "bold",
                          "upcase"
                        ]
                      }
                    },
                    "input": {
                      "display": {
                        "classes": [
                          "red"
                        ]
                      }
                    }
                  }
                ]
              }
            ]
          },
          {
            "name": "Details",
            "heading": "Let's talk about your post..",
            "description": "Provide details and metadata that will enhance search or inform end-users.",
            "columns": [
              {
                "heading": "Publishing (Optional Heading)",
                "grid_width": 6,
                "fields": [
                  {
                    "id": blog.fields[6].id
                  },
                  {
                    "id": blog.fields[7].id
                  },
                  {
                    "id": blog.fields[5].id
                  }
                ]
              },
              {
                "grid_width": 6,
                "fields": [
                  {
                    "id": blog.fields[2].id
                  },
                  {
                    "id": blog.fields[3].id
                  },
                  {
                    "id": blog.fields[4].id
                  }
                ]
              }
            ]
          },
          {
            "name": "Search",
            "heading": "How can others find your post..",
            "description": "Provide SEO metadata to help your post get found by your Users!",
            "columns": [
              {
                "heading": "Publishing (Optional Heading)",
                "grid_width": 6,
                "fields": [
                  {
                    "id": blog.fields[8].id
                  },
                  {
                    "id": blog.fields[10].id
                  },
                  {
                    "id": blog.fields[9].id
                  }
                ]
              },
              {
                "grid_width": 6,
                "fields": [
                  {
                    "id": blog.fields[11].id
                  },
                  {
                    "id": blog.fields[12].id
                  },
                  {
                    "id": blog.fields[13].id
                  },
                  {
                    "id": blog.fields[14].id
                  },
                  {
                    "id": blog.fields[15].id
                  },
                  {
                    "id": blog.fields[16].id
                  }
                ]
              }
            ]
          }
        ]
      }

      blog_wizard_decorator = Decorator.new(name: "Wizard", data: wizard_hash)
      blog_wizard_decorator.save

      ContentableDecorator.create({
        decorator_id: blog_wizard_decorator.id,
        contentable_id: blog.id,
        contentable_type: 'ContentType'
      })

      puts "Creating Index Decorators..."
      index_hash = {
      "columns":
        [
          {
            "name": "Title",
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
            "name": "Post Details",
            "cells": [
              {
                "field": {
                  "id": "274"
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
                  "id": "277"
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
                  "id": "279"
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

      blog_index_decorator = Decorator.new(name: "Index", data: index_hash)
      blog_index_decorator.save

      ContentableDecorator.create({
        decorator_id: blog_index_decorator.id,
        contentable_id: blog.id,
        contentable_type: 'ContentType'
      })
    end
  end
end
