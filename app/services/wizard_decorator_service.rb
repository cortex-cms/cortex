class WizardDecoratorService < CortexService
  attribute :content_item, ContentItem

  def parsed
    steps = steps
    steps.each do |step|

    end
  end

  def steps
    data[:steps]
  end

  def columns(step)
  end

  def fields(column)
  end

  def data
    # @content_item.content_type.wizard_decorator.data
    {
      "steps": [
        {
          "name": "Write",
          "heading": "First thing's first..",
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
                  "id": 1,
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
          "heading": "Let's talk about your post.. (optional)",
          "columns": [
            {
              "heading": "Publishing (Optional Heading)",
              "grid_width": 6,
              "fields": [
                {
                  "id": 2
                }
              ]
            },
            {
              "grid_width": 6,
              "fields": [
                {
                  "id": 3
                },
                {
                  "id": 4
                }
              ]
            }
          ]
        }
      ]
    }
  end
end
