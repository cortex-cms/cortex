class LegacyController < ApplicationController
  before_action :authenticate_user!, :add_gon

  def index
    render layout: 'legacy_application'
  end

  private

  def add_gon
    gon.push({
               current_user: current_user.as_json,
               settings: {
                 cortex_base_url: "#{Cortex.config.cortex.api.base_url}api/#{Cortex.config.cortex.api.version}",
                 paging: {
                   defaultPerPage: 10
                 }
               }
             })
  end
end
