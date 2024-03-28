class Api::V0::VendorsController < ApplicationController
  def index
    market = Market.find(params[:market_id]) 
    render json: VendorSerializer.new(market.vendors)
  end

  def show
    render json: VendorSerializer.new(Vendor.find(params[:id]))
  end

  def create
    vendor = Vendor.create!(vendor_params)
    # render json: VendorSerializer.format_vendor(vendor), status: 201
    render json: VendorSerializer.new(vendor), status: 201
  end

  def destroy
    Vendor.delete(params[:id])
    render json: Vendor.delete(params[:id]), status: 204
  end

  def update
    render json: VendorSerializer.format_vendor(Vendor.update!(params[:id], vendor_params))
  end

  private

  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end
end

