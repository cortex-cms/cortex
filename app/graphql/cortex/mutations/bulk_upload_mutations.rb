module Cortex
  module BulkUploadMutations
    Create = GraphQL::Relay::Mutation.define do
      name "createBulkUpload"
      description "Initiate a Bulk Upload for a model by providing a CSV and ZIP"

      input_field :title, types.String
      input_field :content, types.String
      input_field :metadata, ApolloUploadServer::Upload
      input_field :assets, ApolloUploadServer::Upload

      return_field :post, PostType
      return_field :messages, types[FieldErrorType]

      resolve(Auth.protect ->(obj, inputs, ctx) {
        new_post = ctx[:current_user].posts.build(inputs.to_params)

        if new_post.save
          { post: new_post }
        else
          { messages: new_post.fields_errors }
        end
      })
    end
  end
end
