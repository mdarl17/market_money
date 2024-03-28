require "rails_helper" 

RSpec.describe "Api::V0::Markets", :vcr, type: :request do 
	it "GET /api/v0/markets - returns all markets in the database" do
		load_test_data

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
		load_test_data

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
		load_test_data

		market_id = 324123

		get "/api/v0/markets/#{market_id}", headers: { "Content-Type": "application/json" }

		parsed = JSON.parse(response.body, symbolize_names: true)

		expect(response).to have_http_status(404)
		expect(parsed[:errors].first[:detail]).to eq("Couldn't find Market with 'id'=324123")
	end

	# happy path
	it "GET /api/v0/markets/:id/vendors - returns all vendors who sell products at a particular market", skip_global_data: true do
		load_test_data

		api_res = Market.all.map.with_index do |market, idx|
			get "/api/v0/markets/#{market.id}/vendors", headers: { "Content-Type": "application/json" }
			{ market: market.name, response: JSON.parse(response.body, symbolize_names: true) }
		end

		vendor1 = api_res.first[:response][:data]
		vendor2 = api_res.second[:response][:data]
		vendor3 = api_res.third[:response][:data]

		vendor_keys = Market.all.first.vendors.first.attributes.transform_keys(&:to_sym).keys
		expect(vendor1.count).to eq(Market.all[i].vendor_count)
		expect(market_1.first[:type]).to eq("vendor")
		expect(market_1).to be_an(Array)
		expect(market.first[:attributes]).to be_a(Hash)
		expect(market.first[:attributes].keys).to match_array([
			:contact_name, :contact_phone, :credit_accepted, :description, :name
		])
		require 'pry'; binding.pry
		expect(market.first[:attributes][:description]).to eq(Market.all[i].vendors[i].description)
		expect(market.first[:attributes][:contact_name]).to eq(Market.all[i].vendors[i].contact_name)
		expect(market.first[:attributes][:contact_phone]).to eq(Market.all[i].vendors[i].contact_phone)
		expect(market.first[:attributes][:credit_accepted]).to eq(Market.all[i].vendors[i].credit_accepted)
	end
end