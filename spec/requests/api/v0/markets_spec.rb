require "rails_helper" 

RSpec.describe "Api::V0::Markets", :vcr, type: :request do 
	before(:each) do 
		create_list(:market, 3)
		create_list(:vendor, 5)

		MarketVendor.create!(market_id: Market.first.id, vendor_id: Vendor.first.id)
		MarketVendor.create!(market_id: Market.first.id, vendor_id: Vendor.fourth.id)
		MarketVendor.create!(market_id: Market.first.id, vendor_id: Vendor.fourth.id)
		MarketVendor.create!(market_id: Market.second.id, vendor_id: Vendor.second.id)
		MarketVendor.create!(market_id: Market.third.id, vendor_id: Vendor.fifth.id)
		
		WebMock.allow_net_connect!
	end

	it "GET /api/v0/markets - returns all markets in the database" do
		markets = Market.all

		get "/api/v0/markets", headers: { "Content-Type": "application/json" }

		expect(response).to have_http_status(200)

		parsed = JSON.parse(response.body, symbolize_names: true)

		expect(parsed[:data].first[:type]).to eq("market")
		expect(parsed[:data].first[:attributes][:vendor_count]).to eq(3)
		expect(parsed[:data].first[:attributes][:name]).to eq(Market.first.name)
		expect(parsed[:data].first[:attributes][:street]).to eq(Market.first.street)
		expect(parsed[:data].first[:attributes][:city]).to eq(Market.first.city)
		expect(parsed[:data].first[:attributes][:county]).to eq(Market.first.county)
		expect(parsed[:data].first[:attributes][:state]).to eq(Market.first.state)
		expect(parsed[:data].first[:attributes][:zip]).to eq(Market.first.zip)
		expect(parsed[:data].first[:attributes][:lat]).to eq(Market.first.lat)
		expect(parsed[:data].first[:attributes][:lon]).to eq(Market.first.lon)

		expect(parsed[:data].second[:type]).to eq("market")
		expect(parsed[:data].second[:attributes][:vendor_count]).to eq(1)
		expect(parsed[:data].second[:attributes][:name]).to eq(Market.second.name)
		expect(parsed[:data].second[:attributes][:street]).to eq(Market.second.street)
		expect(parsed[:data].second[:attributes][:city]).to eq(Market.second.city)
		expect(parsed[:data].second[:attributes][:county]).to eq(Market.second.county)
		expect(parsed[:data].second[:attributes][:state]).to eq(Market.second.state)
		expect(parsed[:data].second[:attributes][:zip]).to eq(Market.second.zip)
		expect(parsed[:data].second[:attributes][:lat]).to eq(Market.second.lat)
		expect(parsed[:data].second[:attributes][:lon]).to eq(Market.second.lon)

		expect(parsed[:data].third[:type]).to eq("market")
		expect(parsed[:data].third[:attributes][:vendor_count]).to eq(1)
		expect(parsed[:data].third[:attributes][:name]).to eq(Market.third.name)
		expect(parsed[:data].third[:attributes][:street]).to eq(Market.third.street)
		expect(parsed[:data].third[:attributes][:city]).to eq(Market.third.city)
		expect(parsed[:data].third[:attributes][:county]).to eq(Market.third.county)
		expect(parsed[:data].third[:attributes][:state]).to eq(Market.third.state)
		expect(parsed[:data].third[:attributes][:zip]).to eq(Market.third.zip)
		expect(parsed[:data].third[:attributes][:lat]).to eq(Market.third.lat)
		expect(parsed[:data].third[:attributes][:lon]).to eq(Market.third.lon)
	end
end