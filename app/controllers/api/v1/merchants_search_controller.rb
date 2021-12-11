class Api::V1::MerchantsSearchController < ApplicationController
  def find
    if Merchant.find_by_name(params[:name]) == nil || params[:name] == ""
      render json: { data: { details: "No merchant matches this name" }}, status: 404
    else
      render json: MerchantSerializer.new(Merchant.find_by_name(params[:name]))
    end
  end

  def find_all
    if Merchant.find_all_by_name(params[:name]) == [] || params[:name] == ""
      render json: { data: { details: "No merchant(s) match this name" }}, status: 404
    else
      render json: MerchantSerializer.new(Merchant.find_all_by_name(params[:name]))
    end
  end
end
