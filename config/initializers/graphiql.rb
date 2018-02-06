require 'graphiql/rails'

GraphiQL::Rails.config.initial_query = <<~HEREDOC
# Welcome to Cortex CMS's GraphiQL IDE
#
# GraphiQL is an in-browser tool for writing, validating, and
# testing GraphQL queries.
#
# Type queries into this side of the screen, and you will see intelligent
# typeaheads aware of the current GraphQL type schema and live syntax and
# validation errors highlighted within the text.
#
# GraphQL queries typically start with a "{" character. Lines that starts
# with a # are ignored.
#
# An example GraphQL query might look like:
#
#     {
#       currentUser {
#         firstname
#         lastname
#       }
#       
#       allEmployerBlogs {
#         id
#         updated_by {
#           lastname
#         }
#         content_type {
#           name
#           publishable
#         }
#         allFieldItems {
#           id
#           data
#         }
#       }
#     }
#
# Keyboard shortcuts:
#
#  Prettify Query:  Shift-Ctrl-P (or press the prettify button above)
#
#       Run Query:  Ctrl-Enter (or press the play button above)
#
#   Auto Complete:  Ctrl-Space (or just start typing)
#
# For more detailed information and tutorials, visit https://docs.cortexcms.org
#

HEREDOC
