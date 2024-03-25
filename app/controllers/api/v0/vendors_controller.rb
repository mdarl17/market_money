class Api::V0::VendorsController < ApplicationController

  def show
    vendor = Vendor.find(params[:id])
    render json: VendorSerializer.format_vendor(vendor)
  end

end

