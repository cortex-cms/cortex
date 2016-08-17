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
                  "id": 159,
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
                  "id": 160,
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
                  "id": 165
                },
                {
                  "id": 166
                },
                {
                  "id": 164
                }
              ]
            },
            {
              "grid_width": 6,
              "fields": [
                {
                  "id": 161
                },
                {
                  "id": 162
                },
                {
                  "id": 163
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
                  "id": 167
                },
                {
                  "id": 169
                },
                {
                  "id": 168
                }
              ]
            },
            {
              "grid_width": 6,
              "fields": [
                {
                  "id": 170
                },
                {
                  "id": 171
                },
                {
                  "id": 172
                },
                {
                  "id": 173
                },
                {
                  "id": 174
                },
                {
                  "id": 175
                }
              ]
            }
          ]
        }
      ]
    }
  end
end
