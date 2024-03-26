require 'rails_helper'

RSpec.describe "Market Money API Vendor" do
  it 'can return one vendor' do
    id = create(:vendor, credit_accepted: false).id

    get "/api/v0/vendors/#{id}"

    expect(response).to be_successful

    vendor_data = JSON.parse(response.body, symbolize_names: true)

    expect(vendor_data).to have_key(:data)
    expect(vendor_data[:data]).to be_a(Hash)

    expect(vendor_data[:data]).to have_key(:id)
    expect(vendor_data[:data][:id]).to be_a(String)

    expect(vendor_data[:data]).to have_key(:type)
    expect(vendor_data[:data][:type]).to be_a(String)

    expect(vendor_data[:data]).to have_key(:attributes)
    expect(vendor_data[:data][:attributes]).to be_a(Hash)

    expect(vendor_data[:data][:attributes]).to have_key(:name)
    expect(vendor_data[:data][:attributes][:name]).to be_a(String)

    expect(vendor_data[:data][:attributes]).to have_key(:description)
    expect(vendor_data[:data][:attributes][:description]).to be_a(String)

    expect(vendor_data[:data][:attributes]).to have_key(:contact_name)
    expect(vendor_data[:data][:attributes][:contact_name]).to be_a(String)

    expect(vendor_data[:data][:attributes]).to have_key(:contact_phone)
    expect(vendor_data[:data][:attributes][:contact_phone]).to be_a(String)

    expect(vendor_data[:data][:attributes]).to have_key(:credit_accepted)
    expect(vendor_data[:data][:attributes][:credit_accepted]).to eq(false)
  end

  it 'will return the correct 404 error message when recieving a non existing ID number' do
    get "/api/v0/vendors/0000"
    
    expect(response).not_to be_successful

    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data).to have_key(:errors)
    
    expect(response_data[:errors]).to be_a(Array)
    expect(response_data[:errors].first).to be_a(Hash)
    expect(response_data[:errors].first[:detail]).to eq("Couldn't find Vendor with 'id'=0000")
  end
end