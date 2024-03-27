class Api::V0::VendorsController < ApplicationController
  def show
    render json: VendorSerializer.format_vendor(Vendor.find(params[:id]))
  end

  def create
    vendor = Vendor.create!(vendor_params)
    render json: VendorSerializer.format_vendor(vendor), status: 201
  end

  def destroy
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

