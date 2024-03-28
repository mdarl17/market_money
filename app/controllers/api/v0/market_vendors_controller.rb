class Api::V0::MarketVendorsController < ApplicationController

  def create
    market_vendor = MarketVendor.create!(market_vendor_params)
    render json: {message: "Successfully added vendor to market"}, status: 201
  end

  def destroy
    market_vendor = MarketVendor.find_by(market_vendor_params)
    unless market_vendor == nil
      render json: MarketVendor.delete(market_vendor.id), status: 204
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  private
  def market_vendor_params
    params.require(:market_vendor).permit(:market_id, :vendor_id)
  end

end