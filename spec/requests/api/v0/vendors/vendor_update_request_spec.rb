require 'rails_helper'

RSpec.describe 'Market Money API Update' do
  it 'can update a vendor' do
    id = create(:vendor).id
    previous_name = Vendor.last.name

    vendor_params = {name: "Scary Terry's Confectionaries"}
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v0/vendors/#{id}", headers: headers, params: JSON.generate({vendor: vendor_params})
    vendor = Vendor.find_by(id: id)

    expect(response).to be_successful
    expect(vendor.name).not_to eq(previous_name)
    expect(vendor.name).to eq("Scary Terry's Confectionaries")
  end

  it 'can update different attributes at the same time' do
    id = create(:vendor).id
    previous_description = Vendor.last.description
    previous_name = Vendor.last.name
    previous_contact_phone = Vendor.last.contact_phone

    vendor_params = {description: "Really bad products but fun people", name: "Scary Terry's Confectionaries", contact_phone: "1-800-dont-call"}
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v0/vendors/#{id}", headers: headers, params: JSON.generate({vendor: vendor_params})
    vendor = Vendor.find_by(id: id)

    expect(response).to be_successful
    expect(vendor.description).not_to eq(previous_description)
    expect(vendor.description).to eq("Really bad products but fun people")
    expect(vendor.name).not_to eq(previous_name)
    expect(vendor.name).to eq("Scary Terry's Confectionaries")
    expect(vendor.contact_phone).not_to eq(previous_contact_phone)
    expect(vendor.contact_phone).to eq("1-800-dont-call")
  end

  it 'will raise an error if trying to update a record with a blank attribute' do
    id = create(:vendor).id
    previous_description = Vendor.last.description

    vendor_params = {description: ""}
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v0/vendors/#{id}", headers: headers, params: JSON.generate({vendor: vendor_params})
    vendor = Vendor.find_by(id: id)

    expect(response).not_to be_successful

    error_data = JSON.parse(response.body, symbolize_names: true)
    
    expect(error_data).to have_key(:errors)
    expect(error_data[:errors]).to be_a(Array)
    expect(error_data[:errors].first).to be_a(Hash)
    expect(error_data[:errors].first).to have_key(:detail)
    expect(error_data[:errors].first[:detail]).to eq("Validation failed: Description can't be blank")
  end
end