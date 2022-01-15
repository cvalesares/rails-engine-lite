class Api::V1::ItemsSearchController < ApplicationController
  def find_all
    if Item.find_all_by_name(params[:name]) == [] || params[:name] == ""
      render json: { data: { details: "No item matches this name" }}, status: 404
    else
      render json: ItemSerializer.new(Item.find_all_by_name(params[:name]))
    end
  end
end

#for find single by name try -ln4.first
#.limit(1) would work here if we needed it in an array
