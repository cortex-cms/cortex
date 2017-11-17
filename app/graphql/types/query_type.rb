Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  field :currentUser, !Types::UserType do
    resolve ->(_obj, _args, ctx) {
      ctx[:current_user]
    }
  end

  field :allUsers, types[Types::UserType] do
    resolve -> (_obj, _args, _ctx) {
      # TODO: scope to tenant; allow tenant argument
      User.all
    }
  end

  # TODO: extract to class
  ContentType.find_each do |content_type|
    all_field_for_content_type(content_type)
    # field_for_content_type(content_type)
    # ...
  end
end

def all_field_for_content_type(content_type)
  field(field_name('all', content_type), types[Types::ContentItemType]) do
    argument :page, types.Int
    argument :limit, types.Int
    argument :tenant_id, types.ID # TODO: check that tenant_id within active_tenant and authorize. Which layer should this occur in?

    description content_type.description

    resolve -> (_obj, args, ctx) {
      params = { args: args, active_tenant: ctx[:current_user].active_tenant, content_type: content_type }
      GetContentItemsForContentTypeTransaction.new.call(params).value
    }
  end
end

def field_name(prefix, content_type) # TODO: extract
  prefix + content_type.name_id.camelize.pluralize
end
