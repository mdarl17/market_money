class Api::V0::VendorsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :invalid_record_response

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

  private
  def not_found_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404)).serialize_json, status: :not_found
  end

  def invalid_record_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 400)).serialize_json, status: 400
  end

  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end
end

