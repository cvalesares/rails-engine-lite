class Api::V1::ItemMerchantsController < ApplicationController
  def show
    item = Item.find(params[:item_id])
    merchant = Merchant.where("id = #{item.merchant_id}")
    
    render json: MerchantSerializer.new(merchant.first)
  end
end
