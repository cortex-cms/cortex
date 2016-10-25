Bundler.require(:default, Rails.env)

namespace :employer do
  namespace :blog do
    desc 'Seed Employer Blog ContentType and Fields'
    task seed: :environment do
      def audience_tree
        tree = Tree.new
        tree.add_node({ name: "Job Seeker" })
        tree.add_node({ name: "Employer" })

        tree
      end

      def vertical_tree
        tree = Tree.new
        tree.add_node({ name: "Small Business" })
        tree.add_node({ name: "Recruiting and Staffing" })
        tree.add_node({ name: "Health Care" })

        tree
      end

      def research_tree
        tree = Tree.new
        tree.add_node({ name: "CB Research" })
        tree.add_node({ name: "Third Party Research" })

        tree
      end

      def category_tree
        tree = Tree.new
        tree.add_node({ name: "Candidate Experience" }) #1
        tree.add_node({ name: "CareerBuilder Solutions" }) #2
        tree.add_node({ name: "Data and Analytics" }) #3
        tree.add_node({ name: "Events" }) #4
        tree.add_node({ name: "Health Care" }) #5
        tree.add_node({ name: "Hiring Strategy" }) #6
        tree.add_node({ name: "Leadership" }) #7
        tree.add_node({ name: "News and Trends" }) #8
        tree.add_node({ name: "Other Stuff" }) #9
        tree.add_node({ name: "Recruitment Techniques" }) #10
        tree.add_node({ name: "Recruitment Technology" }) #11
        tree.add_node({ name: "Reports" }) #12
        tree.add_node({ name: "BLS Reports" }, 12) #13
        tree.add_node({ name: "Economy" }, 12) #14
        tree.add_node({ name: "Forecasts" }, 12) #15
        tree.add_node({ name: "Infographics" }, 12) #16
        tree.add_node({ name: "Survey Results" }, 12) #17
        tree.add_node({ name: "Small Business" }) #18
        tree.add_node({ name: "Staffing & Recruiting" }) #19
        tree.add_node({ name: "Talent Acquisition" }) #20
        tree.add_node({ name: "Employment Branding" }, 20) #21
        tree.add_node({ name: "Generational Hiring" }, 20) #22
        tree.add_node({ name: "HR Software" }, 20) #23
        tree.add_node({ name: "Job Postings" }, 20) #24
        tree.add_node({ name: "Mobile" }, 20) #25
        tree.add_node({ name: "Selection" }, 20) #26
        tree.add_node({ name: "Workforce Data" }, 20) #27
        tree.add_node({ name: "Talent Advisor" }) #28
        tree.add_node({ name: "Talent Factor" }) #29
        tree.add_node({ name: "Talent Management" }) #30
        tree.add_node({ name: "Benefits" }, 30) #31
        tree.add_node({ name: "Diversity in the Workplace" }, 30) #32
        tree.add_node({ name: "Onboarding" }, 30) #33
        tree.add_node({ name: "Retention" }, 30) #34
        tree.add_node({ name: "Talent Development" }, 30) #35
        tree.add_node({ name: "Talent Sourcing" }) #36
        tree.add_node({ name: "Workplace Insight" }) #37

        tree
      end

      def persona_tree
        tree = Tree.new
        tree.add_node({ name: "Persona 1" })
        tree.add_node({ name: "Persona 2" })

        tree
      end

      def seed_industries
        puts 'Seeding Industries (Job Families)..'

      end

      def onet_tree
        tree = Tree.new

        industries_seed = SeedData.onet_industries

        industries_seed.each do |industry|
          tree.add_node({ name: industry[:title] })
        end

        Onet::Occupation.industries.each do |onet_code|
        end

        tree
      end

      puts "Creating Employer Blog ContentType..."
      blog = ContentType.new({
        name: "Employer Blog",
        description: "Blog for Employer",
        icon: "description",
        creator_id: 1,
        contract_id: 1,
        publishable: true
      })
      blog.save

      puts "Creating Fields..."
      blog.fields.new(name: 'Body', field_type: 'text_field_type', metadata: { wysiwyg: true, parse_widgets: true })
      blog.fields.new(name: 'Title', field_type: 'text_field_type', validations: { presence: true })
      blog.fields.new(name: 'Description', field_type: 'text_field_type', validations: { presence: true })
      blog.fields.new(name: 'Slug', field_type: 'text_field_type', validations: { presence: true })
      blog.fields.new(name: 'Author', field_type: 'user_field_type', validations: { presence: true })
      blog.fields.new(name: 'Tags', field_type: 'tag_field_type')
      blog.fields.new(name: 'Publish Date', field_type: 'date_time_field_type')
      blog.fields.new(name: 'Expiration Date', field_type: 'date_time_field_type')
      blog.fields.new(name: 'SEO Title', field_type: 'text_field_type')
      blog.fields.new(name: 'SEO Description', field_type: 'text_field_type')
      blog.fields.new(name: 'SEO Keywords', field_type: 'tag_field_type')
      blog.fields.new(name: 'No Index', field_type: 'boolean_field_type')
      blog.fields.new(name: 'No Follow', field_type: 'boolean_field_type')
      blog.fields.new(name: 'No Snippet', field_type: 'boolean_field_type')
      blog.fields.new(name: 'No ODP', field_type: 'boolean_field_type')
      blog.fields.new(name: 'No Archive', field_type: 'boolean_field_type')
      blog.fields.new(name: 'No Image Index', field_type: 'boolean_field_type')
      blog.fields.new(name: 'Categories', field_type: 'tree_field_type', metadata: { allowed_values: category_tree }, validations: { maximum: 2 })
      blog.fields.new(name: 'Audience', field_type: 'tree_field_type', metadata: { allowed_values: audience_tree }, validations: { maximum: 1, minimum: 1 })
      blog.fields.new(name: 'Verticals', field_type: 'tree_field_type', metadata: { allowed_values: vertical_tree }, validations: { minimum: 1 })
      blog.fields.new(name: 'Research', field_type: 'tree_field_type', metadata: { allowed_values: research_tree }, validations: { minimum: 1 })
      blog.fields.new(name: 'Persona', field_type: 'tree_field_type', metadata: { allowed_values: persona_tree })
      blog.fields.new(name: 'Onet Code', field_type: 'tree_field_type', metadata: { allowed_values: onet_tree })

      puts "Saving Employer Blog..."
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
                "elements": [
                  {
                    "plugin": {
                      "class_name": "plugins/demo/demo",
                      "render_method": "marquee",
                      "data": {
                        "field_id": blog.fields.find_by_name('Title').id,
                      },
                      "display": {
                        "id": ["random", "list", "of", "ids"]
                      }
                    }
                  },
                  {
                    "id": blog.fields.find_by_name('Body').id,
                    "render_method": "wysiwyg",
                    "input": {
                      "display": {
                        "styles": {
                          "height": "500px"
                        }
                      }
                    }
                  },
                  {
                    "method": "test_method"
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
                "elements": [
                  {
                    "id": blog.fields.find_by_name('Title').id
                  },
                  {
                    "id": blog.fields.find_by_name('Publish Date').id
                  },
                  { 
                    "id": blog.fields.find_by_name('Expiration Date').id
                  },
                  {
                    "id": blog.fields.find_by_name('Tags').id
                  }
                ]
              },
              {
                "grid_width": 6,
                "elements": [
                  {
                    "id":  blog.fields.find_by_name('Description').id
                  },
                  {
                    "id":  blog.fields.find_by_name('Slug').id
                  },
                  {   
                    "id": blog.fields.find_by_name('Author').id
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
                "elements": [
                  {
                    "id": blog.fields.find_by_name('SEO Title').id
                  },
                  {
                    "id": blog.fields.find_by_name('SEO Keywords').id
                  },
                  {
                    "id": blog.fields.find_by_name('SEO Description').id
                  }
                ]
              },
              {
                "grid_width": 6,
                "elements": [
                  {
                    "id": blog.fields.find_by_name('No Index').id
                  },
                  {
                    "id": blog.fields.find_by_name('No Follow').id
                  },
                  {
                    "id": blog.fields.find_by_name('No Snippet').id
                  },
                  {
                    "id": blog.fields.find_by_name('No ODP').id
                  },
                  {
                    "id": blog.fields.find_by_name('No Archive').id
                  },
                  {
                    "id": blog.fields.find_by_name('No Image Index').id
                  }
                ]
              }
            ]
          },
          {
            "name": "Categorize",
            "heading": "Sort Into Categories..",
            "description": "Select the categories that best describe your post.",
            "columns": [
              {
                "heading": "Publishing (Optional Heading)",
                "grid_width": 6,
                "elements": [
                  {
                    "id": blog.fields.find_by_name('Categories').id,
                    "render_method": "checkboxes"
                  }
                ]
              },
              {
                "grid_width": 6,
                "elements": [
                  {
                    "id": blog.fields.find_by_name('Audience').id,
                    "render_method": "dropdown"
                  },
                  {
                    "id": blog.fields.find_by_name('Verticals').id,
                    "render_method": "dropdown"
                  },
                  {
                    "id": blog.fields.find_by_name('Research').id,
                    "render_method": "dropdown"
                  },
                  {
                    "id": blog.fields.find_by_name('Persona').id,
                    "render_method": "dropdown"
                  },
                  {
                    "id": blog.fields.find_by_name('Onet Code').id,
                    "render_method": "dropdown"
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
            "name": "Author",
            "grid_width": 2,
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
                  "id": blog.fields.find_by_name('Title').id
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
                  "id": blog.fields.find_by_name('Slug').id
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
                  "id": blog.fields.find_by_name('Tags').id
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

      Rake::Task['plugin:demo:seed'].execute
    end
  end
end