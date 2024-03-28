require "rails_helper" 

RSpec.describe "Api::V0::Markets", :vcr, type: :request do 
	before(:each) do 
		create_list(:market, 3)
		create_list(:vendor, 5)

		MarketVendor.create!(market_id: Market.first.id, vendor_id: Vendor.first.id)
		MarketVendor.create!(market_id: Market.first.id, vendor_id: Vendor.fourth.id)
		MarketVendor.create!(market_id: Market.second.id, vendor_id: Vendor.fourth.id)
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
		
		parsed[:data].count.times do |idx| 
			expect(parsed[:data][idx][:attributes][:vendor_count]).to eq(Market.all[idx].vendor_count)
			expect(parsed[:data][idx][:attributes][:name]).to eq(Market.all[idx].name)
			expect(parsed[:data][idx][:attributes][:street]).to eq(Market.all[idx].street)
			expect(parsed[:data][idx][:attributes][:city]).to eq(Market.all[idx].city)
			expect(parsed[:data][idx][:attributes][:county]).to eq(Market.all[idx].county)
			expect(parsed[:data][idx][:attributes][:state]).to eq(Market.all[idx].state)
			expect(parsed[:data][idx][:attributes][:zip]).to eq(Market.all[idx].zip)
			expect(parsed[:data][idx][:attributes][:lat]).to eq(Market.all[idx].lat)
			expect(parsed[:data][idx][:attributes][:lon]).to eq(Market.all[idx].lon)
		end
	end
	
	# happy path
	it "GET /api/v0/markets/:id - returns the market that matches the provided market ID" do 
		market = Market.all.sample

		get "/api/v0/markets/#{market.id}", headers: { "Content-Type": "application/json" }

		expect(response).to have_http_status(200)

		parsed = JSON.parse(response.body, symbolize_names: true)

		expect(parsed[:data][:attributes][:vendor_count]).to eq(market.vendor_count)
		expect(parsed[:data][:attributes][:name]).to eq(market.name)
		expect(parsed[:data][:attributes][:street]).to eq(market.street)
		expect(parsed[:data][:attributes][:city]).to eq(market.city)
		expect(parsed[:data][:attributes][:county]).to eq(market.county)
		expect(parsed[:data][:attributes][:state]).to eq(market.state)
		expect(parsed[:data][:attributes][:zip]).to eq(market.zip)
		expect(parsed[:data][:attributes][:lat]).to eq(market.lat)
		expect(parsed[:data][:attributes][:lon]).to eq(market.lon)
	end

	# sad path
	it "GET /api/v0/markets/:id - returns an error message if no markets with the given ID can be found" do 
		market_id = 324123

		get "/api/v0/markets/#{market_id}"

		parsed = JSON.parse(response.body, symbolize_names: true)
		expect(response).to have_http_status(404)
		expect(parsed[:errors].first[:detail]).to eq("Couldn't find Market with 'id'=324123")
	end
end