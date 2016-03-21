module API
  module V1
    module Helpers
      module ParamsHelper
        def remove_params(params, *remove)
          new_params = params
          remove.each do |r|
            new_params.delete(r)
          end
          new_params
        end

        def clean_params(params)
          Hashie::Mash.new(params.reject do |_,v|
            v.blank?
          end)
        end
      end
    end
  end
end
