require_relative '../helpers/resource_helper'

module API
  module V1
    module Resources
      class Documents < Grape::API
        helpers Helpers::SharedParams
        doorkeeper_for :all, scopes: [:public]

        resource :documents do
          helpers Helpers::PaginationHelper
          helpers Helpers::DocumentsHelper

          desc 'Show all documents', { entity: Entities::Document, nickname: 'showAllDocument' }
          params do
            use :pagination
          end
          get scopes: [:'view:documents'] do
            authorize! :view, ::Document

            @document = ::Document.order(created_at: :desc).page(page).per(per_page)
            set_pagination_headers(@document, 'document')
            present @document, with: Entities::Document
          end

          desc 'Get document', { entity: Entities::Document, nickname: 'showDocument' }
          get ':id', scopes: [:'view:documents'] do
            authorize! :view, document!

            present document, with: Entities::Document
          end

          desc 'Create document', { entity: Entities::Document, params: Entities::Document.documentation, nickname: 'createDocument' }
          post scopes: [:'modify:documents'] do
            authorize! :create, ::Document

            document_params = params[:document] || params

            @document = ::Document.new(declared(document_params, { include_missing: false }, Entities::Document.documentation.keys))
            document.user = current_user!
            document.save!

            present document, with: Entities::Document
          end

          desc 'Update document', { entity: Entities::Document, params: Entities::Document.documentation, nickname: 'updateDocument' }
          put ':id', scopes: [:'modify:documents'] do
            authorize! :update, document!

            document_params = params[:document] || params

            document.update!(declared(document_params, { include_missing: false }, Entities::Document.documentation.keys))

            present document, with: Entities::Document
          end

          desc 'Delete document', { nickname: 'deleteDocument' }
          delete ':id', scopes: [:'modify:documents'] do
            authorize! :delete, document!

            begin
              document.destroy
            rescue Cortex::Exceptions::ResourceConsumed => e
              error = error!({
                               error:   'Conflict',
                               message: e.message,
                               status:  409
                             }, 409)
              error
            end
          end
        end
      end
    end
  end
end
