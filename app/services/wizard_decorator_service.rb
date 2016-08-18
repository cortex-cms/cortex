class WizardDecoratorService < CortexService
  attribute :content_item, ContentItem

  def data
    # @content_item.content_type.wizard_decorator.data
    {
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
                  "id": @content_item.field_items[0].field_id,
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
                  "id": @content_item.field_items[1].field_id,
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
                  "id": @content_item.field_items[6].field_id
                },
                {
                  "id": @content_item.field_items[7].field_id
                },
                {
                  "id": @content_item.field_items[5].field_id
                }
              ]
            },
            {
              "grid_width": 6,
              "fields": [
                {
                  "id": @content_item.field_items[2].field_id
                },
                {
                  "id": @content_item.field_items[3].field_id
                },
                {
                  "id": @content_item.field_items[4].field_id
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
                  "id": @content_item.field_items[8].field_id
                },
                {
                  "id": @content_item.field_items[10].field_id
                },
                {
                  "id": @content_item.field_items[9].field_id
                }
              ]
            },
            {
              "grid_width": 6,
              "fields": [
                {
                  "id": @content_item.field_items[11].field_id
                },
                {
                  "id": @content_item.field_items[12].field_id
                },
                {
                  "id": @content_item.field_items[13].field_id
                },
                {
                  "id": @content_item.field_items[14].field_id
                },
                {
                  "id": @content_item.field_items[15].field_id
                },
                {
                  "id": @content_item.field_items[16].field_id
                }
              ]
            }
          ]
        }
      ]
    }
  end
end
