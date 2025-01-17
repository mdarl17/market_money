class Api::V0::VendorsController < ApplicationController
  def index
    market = Market.find(params[:market_id]) 
    render json: VendorSerializer.new(market.vendors)
  end

  def show
    vendor = Vendor.find(params[:id])
    render json: VendorSerializer.new(vendor)
  end

  def create
    vendor = Vendor.create!(vendor_params)
    render json: VendorSerializer.new(vendor), status: 201
  end

  def destroy
    Vendor.delete(params[:id])
    render json: Vendor.delete(params[:id]), status: 204
  end

  def update
    vendor = Vendor.find(params[:id])
    if vendor.update(vendor_params)
      render json: VendorSerializer.new(vendor)
      return
    else
      render json: ErrorSerializer.new(ErrorMessage.new(vendor.errors, 422)).serialize_json, status: :unprocessable_entity
    end
  end

  private

  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end
end

