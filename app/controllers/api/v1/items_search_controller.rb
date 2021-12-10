class Api::V1::ItemsSearchController < ApplicationController
  def find_all
    if Item.find_all_by_name(params[:name]) == nil || params[:name] == ""
      render json: { data: { details: "No item matches this name" }}, status: 404
    else
      render json: ItemSerializer.new(Item.find_all_by_name(params[:name]))
    end
  end
end
