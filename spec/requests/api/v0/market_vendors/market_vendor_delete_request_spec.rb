require 'rails_helper'

RSpec.describe "Market Money API Delete Request" do
  it 'can delete a MarketVendor via delete request and remove the association record from market and vendor' do
    vendor = create(:vendor)
    market = create(:market)
    market_vendor = MarketVendor.create!(market_id: market.id, vendor_id: vendor.id)

    headers = {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
    market_vendor_params = {market_id: market.id, vendor_id: vendor.id}

    delete "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_vendor_params)

    expect(response).to be_successful
    expect(response.status).to eq(204)
    expect{Vendor.find(market_vendor.id)}.to raise_error(ActiveRecord::RecordNotFound)
    expect(vendor.markets.include?(market)).to eq(false)
    expect(market.vendors.include?(vendor)).to eq(false)
  end
end