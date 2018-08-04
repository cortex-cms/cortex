module Cortex
  Types::QueryType = GraphQL::ObjectType.define do
    name 'Query'

    # TODO: After migration to class-based schemas, move these methods to a concern
    def all_field_for_content_type(content_type)
      field(field_name('all', content_type), types[Cortex::Types::ContentItemType]) do
        argument :page, types.Int
        argument :limit, types.Int
        argument :tenant_id, types.ID # TODO: check that tenant_id within active_tenant and authorize. Which layer should this occur in?

        description content_type.description

        resolve -> (_obj, args, ctx) {
          params = { args: args, active_tenant: ctx[:current_user].active_tenant, content_type: content_type }
          Cortex::GetContentItemsForContentTypeTransaction.new.call(params).value!
        }
      end
    end

    def field_name(prefix, content_type) # TODO: extract
      prefix + content_type.name_id.camelize.pluralize
    end

    field :currentUser, !Cortex::Types::UserType do
      resolve ->(_obj, _args, ctx) {
        ctx[:current_user]
      }
    end

    field :allUsers, types[Cortex::Types::UserType] do
      resolve -> (_obj, _args, _ctx) {
        # TODO: scope to tenant; allow tenant argument
        Cortex::User.all
      }
    end

    # TODO: extract to class
    Cortex::ContentType.find_each do |content_type|
      all_field_for_content_type(content_type)
      # field_for_content_type(content_type)
      # ...
    end
  end
end
