require 'rails_helper'

RSpec.describe "Market Money API Vendor" do
  it 'can create a new vendor' do
    vendor_params = {
      name: "Buzzy Bees",
      description: "local honey and wax products",
      contact_name: "Berly Couwer",
      contact_phone: "8389928383",
      credit_accepted: false
    }

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v0/vendors", headers: headers, params: JSON.generate(vendor: vendor_params)

    new_vendor = Vendor.last

    expect(response).to be_successful
    expect(new_vendor.name).to eq(vendor_params[:name])
    expect(new_vendor.description).to eq(vendor_params[:description])
    expect(new_vendor.contact_name).to eq(vendor_params[:contact_name])
    expect(new_vendor.contact_phone).to eq(vendor_params[:contact_phone])
    expect(new_vendor.credit_accepted).to eq(vendor_params[:credit_accepted])
  end

  it 'will handle errors gracefully when not given all necessary info for vendor' do
    vendor_params = {
      name: "Buzzy Bees",
      description: "local honey and wax products",
      contact_name: "Berly Couwer",
      contact_phone: "8389928383"
    }

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v0/vendors", headers: headers, params: JSON.generate(vendor: vendor_params)

    expect(response).not_to be_successful

    error_data = JSON.parse(response.body, symbolize_names: true)

    expect(error_data).to have_key(:errors)
    expect(error_data[:errors]).to be_a(Array)
    expect(error_data[:errors].first).to be_a(Hash)
    expect(error_data[:errors].first).to have_key(:detail)
    expect(error_data[:errors].first[:detail]).to eq("Validation failed: Credit accepted must be true or false")
  end
end