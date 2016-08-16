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
                  "id": 43,
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
                  "id": 44
                }
              ]
            },
            {
              "grid_width": 6,
              "fields": [
                {
                  "id": 43
                },
                {
                  "id": 44
                }
              ]
            }
          ]
        }
      ]
    }
  end
end
