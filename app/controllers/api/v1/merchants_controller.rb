class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end
end


#sad path for no merchant
# render json: { errors: { details: "No merchant matches this id" }}, status: 404
