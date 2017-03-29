module V1
  module Resources
    class Media < Grape::API
      helpers ::V1::Helpers::SharedParamsHelper
      helpers ::V1::Helpers::ParamsHelper

      resource :media do
        include Grape::Kaminari
        helpers ::V1::Helpers::MediaHelper
        helpers ::V1::Helpers::BulkJobsHelper

        paginate per_page: 25

        desc 'Show all media', { entity: ::V1::Entities::Media, nickname: 'showAllMedia' }
        params do
          use :search
        end
        get do
          authorize! :view, ::Media
          require_scope! 'view:media'

          @media = ::GetMultipleMedia.call(params: declared(clean_params(params), include_missing: false), tenant: current_tenant).media
          set_paginate_headers(@media)
          ::V1::Entities::Media.represent @media.to_a
        end

        desc 'Show media tags'
        params do
          optional :s
        end
        get 'tags' do
          require_scope! 'view:media'
          authorize! :view, ::Media

          tags = params[:s] \
            ? ::Media.tag_counts_on(:tags).where('name ILIKE ?', "%#{params[:s]}%") \
            : ::Media.tag_counts_on(:tags)

          if params[:popular]
            tags = tags.order('count DESC').limit(20)
          end

          present tags, with: ::V1::Entities::Tag
        end

        desc 'Get media', { entity: ::V1::Entities::Media, nickname: 'showMedia' }
        get ':id' do
          require_scope! 'view:media'
          authorize! :view, media!

          present media, with: ::V1::Entities::Media, full: true
        end

        desc 'Create media', { entity: ::V1::Entities::Media, params: ::V1::Entities::Media.documentation, nickname: 'createMedia' }
        params do
          optional :attachment
        end
        post do
          require_scope! 'modify:media'
          authorize! :create, ::Media

          media_params = params[:media] || params

          @media = ::Media.new(declared(media_params, { include_missing: false }, ::V1::Entities::Media.documentation.keys))
          media.user = current_user!
          if params[:tag_list]
            media.tag_list = params[:tag_list]
          end
          media.save!

          present media, with: ::V1::Entities::Media, full: true
        end

        desc 'Update media', { entity: ::V1::Entities::Media, params: ::V1::Entities::Media.documentation, nickname: 'updateMedia' }
        params do
          optional :attachment
        end
        put ':id' do
          require_scope! 'modify:media'
          authorize! :update, media!

          media_params = params[:media] || params

          allowed_params = [:name, :alt, :description, :tag_list, :status, :deactive_at, :attachment]

          if params[:tag_list]
            media.tag_list = params[:tag_list]
          end
          media.update!(declared(media_params, { include_missing: false }, allowed_params))

          present media, with: ::V1::Entities::Media, full: true
        end

        desc 'Delete media', { nickname: 'deleteMedia' }
        delete ':id' do
          require_scope! 'modify:media'
          authorize! :delete, media!

          begin
            media.destroy
          rescue Cortex::Exceptions::ResourceConsumed => e
            error = error!({
                              error:   'Conflict',
                              message: e.message,
                              status:  409
                            }, 409)
            error
          end
        end

        desc 'Bulk create media', { entity: ::V1::Entities::BulkJob, nickname: 'bulkCreateMedia' }
        params do
          group :bulkJob, type: Hash do
            requires :assets
          end
        end
        post :bulk_job do
          require_scope! 'modify:media'
          require_scope! 'modify:bulk_jobs'
          authorize! :create, ::Media
          authorize! :create, ::BulkJob

          bulk_job_params = params[:bulkJob] || params

          @bulk_job = ::BulkJob.new(declared(bulk_job_params, { include_missing: false }, ::V1::Entities::BulkJob.documentation.keys))
          bulk_job.content_type = 'Media'
          bulk_job.user = current_user!
          bulk_job.save!

          BulkCreateMediaJob.perform_later(bulk_job, current_user!)

          present bulk_job, with: ::V1::Entities::BulkJob
        end
      end
    end
  end
end
