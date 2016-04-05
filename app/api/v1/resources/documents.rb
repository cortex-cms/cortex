module V1
  module Resources
    class Documents < Grape::API
      resource :documents do
        include Grape::Kaminari
        helpers ::V1::Helpers::DocumentsHelper

        paginate per_page: 25

        desc 'Show all documents', { entity: ::V1::Entities::Document, nickname: 'showAllDocument' }
        get do
          authorize! :view, ::Document
          require_scope! :'view:documents'

          @document = ::Document.order(created_at: :desc)
          ::V1::Entities::Document.represent paginate(@document)
        end

        desc 'Get document', { entity: ::V1::Entities::Document, nickname: 'showDocument' }
        get ':id' do
          require_scope! :'view:documents'
          authorize! :view, document!

          present document, with: ::V1::Entities::Document
        end

        desc 'Create document', { entity: ::V1::Entities::Document, params: ::V1::Entities::Document.documentation, nickname: 'createDocument' }
        post do
          require_scope! :'modify:documents'
          authorize! :create, ::Document

          document_params = params[:document] || params

          @document = ::Document.new(declared(document_params, { include_missing: false }, ::V1::Entities::Document.documentation.keys))
          document.user = current_user!
          document.save!

          present document, with: ::V1::Entities::Document
        end

        desc 'Update document', { entity: ::V1::Entities::Document, params: ::V1::Entities::Document.documentation, nickname: 'updateDocument' }
        put ':id' do
          require_scope! :'modify:documents'
          authorize! :update, document!

          document_params = params[:document] || params

          document.update!(declared(document_params, { include_missing: false }, ::V1::Entities::Document.documentation.keys))

          present document, with: ::V1::Entities::Document
        end

        desc 'Delete document', { nickname: 'deleteDocument' }
        delete ':id' do
          require_scope! :'modify:documents'
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
