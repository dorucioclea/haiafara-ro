class POIsController < ApplicationController
  def show
    @poi = POI.friendly.find(params[:id])
    @page_title = @poi.name
    @resource_json = POISerializer.new(@poi).serialized_json
  end
end