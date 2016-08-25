class IndexDecoratorService < CortexService
  def data
    # @content_type.index_decorator.data
    {
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
  end
end
