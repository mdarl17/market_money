require 'rails_helper'

RSpec.describe "Market Money API MarketVendor Create" do
  it 'can create a new market vendor with valid market and vendor ids' do
    vendor = create(:vendor)
    market = create(:market)
    
    market_vendor_params = {
      market_id: market.id,
      vendor_id: vendor.id
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_vendor: market_vendor_params)

    created_market_vendor = MarketVendor.last

    expect(response).to be_successful
    expect(created_market_vendor.market_id).to eq(market.id)
    expect(created_market_vendor.vendor_id).to eq(vendor.id)
  end

  it 'responds with a confirmation message that the vendor was successfully added to the market' do
    vendor = create(:vendor)
    market = create(:market)
    
    market_vendor_params = {
      market_id: market.id,
      vendor_id: vendor.id
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_vendor: market_vendor_params)

    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data).to have_key(:message)
    expect(response_data[:message]).to eq("Successfully added vendor to market")
  end

  it 'adds a vendor to the markets vendors endpoint' do
    vendor = create(:vendor)
    market = create(:market)
    market_vendor = MarketVendor.create!(vendor_id: vendor.id, market_id: market.id)

    headers = {"CONTENT_TYPE" => "application/json"}

    get "/api/v0/markets/#{market.id}/vendors", headers: headers

    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data).to have_key(:data)
    expect(response_data[:data].first[:id]).to eq(vendor.id.to_s)
  end

  it 'will respond with a 404 status code if an invalid id is passed in for either market or vendor' do
    vendor = create(:vendor)
    market = create(:market)

    market_vendor_params = {
      market_id: 0000,
      vendor_id: vendor.id
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_vendor: market_vendor_params)

    expect(response).not_to be_successful

    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data).to have_key(:errors)
    expect(response_data[:errors]).to be_a(Array)
    expect(response_data[:errors].first).to have_key(:detail)
    expect(response_data[:errors].first[:detail]).to eq("Validation failed: Market must exist")

    market_vendor_params = {
      market_id: market.id,
      vendor_id: 0000
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_vendor: market_vendor_params)

    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data).to have_key(:errors)
    expect(response_data[:errors]).to be_a(Array)
    expect(response_data[:errors].first).to have_key(:detail)
    expect(response_data[:errors].first[:detail]).to eq("Validation failed: Vendor must exist")
  end

  it 'responds with a 422 status code if there is a market vendor that already exists with that pair of markets and vendors' do
    vendor = create(:vendor)
    market = create(:market)
    market_vendor = MarketVendor.create!(vendor_id: vendor.id, market_id: market.id)

    market_vendor_params = {
      market_id: market.id,
      vendor_id: vendor.id
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_vendor: market_vendor_params)

    expect(response).not_to be_successful

    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data).to have_key(:errors)
    expect(response_data[:errors]).to be_a(Array)
    expect(response_data[:errors].first).to have_key(:detail)
    expect(response_data[:errors].first[:detail]).to eq("Validation failed: Market vendor association between market with market_id=#{market.id} and vendor_id=#{vendor.id} already exists")
  end
end