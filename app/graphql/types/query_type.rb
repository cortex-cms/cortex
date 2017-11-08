Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  # TODO: remove me
  # field :testField, types.String do
  #   description "An example field added by the generator"
  #   resolve ->(obj, args, ctx) {
  #     "Hello World!"
  #   }
  # end

  field :users, !types[Types::UserType] do
    description 'All users'
    resolve -> (obj, args, ctx) {
      User.all
    }
  end

  field :current_user, !Types::UserType do
    description 'Current user'
    resolve ->(obj, args, ctx) {
      ctx[:current_user]
    }
  end

  field :content_items, !types[Types::ContentItemType] do
    argument :page, types.Int
    argument :limit, types.Int

    resolve -> (obj, args, ctx) {
      params = { args: args, tenant: ctx[:current_user].active_tenant }
      GetContentItemsTransaction.new.call(params).value
    }
  end
end
