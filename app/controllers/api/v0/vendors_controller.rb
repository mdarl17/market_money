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
    # render json: VendorSerializer.format_vendor(vendor), status: 201
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
      render json: { errors: vendor.errors }, status: :unprocessable_entity
      # render json: ErrorSerializer.new(ErrorMessage.new(exception.message, status_code)).serialize_json, status: status_code
    end
  end
  # render json: VendorSerializer.new(updated_ven), status: 200
  # render json: VendorSerializer.format_vendor(Vendor.update(params[:id], vendor_params))
  private

  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end
end

