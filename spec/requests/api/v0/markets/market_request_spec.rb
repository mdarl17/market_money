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

		@headers = { Content_Type: "application/json" }

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

	describe "markets search" do
		it "users can search for markets by state" do 
			record = Market.all.sample
			name = record.name
			city = record.city
			state = record.state

			get "/api/v0/markets/search", headers: @headers, params: { state: state }

			parsed = JSON.parse(response.body, symbolize_names: true)
			
			expect(response).to have_http_status(200)

			expect(parsed[:data].first[:id].to_i).to eq(record.id)
			expect(parsed[:data].first[:type]).to eq("market")
			expect(parsed[:data].first[:attributes][:name]).to eq(name)
			expect(parsed[:data].first[:attributes][:city]).to eq(city)
			expect(parsed[:data].first[:attributes][:state]).to eq(state)
			expect(parsed[:data].first[:attributes][:vendor_count]).to eq(record.vendor_count)
			expect(parsed[:data].first[:attributes][:street]).to eq(record.street)
			expect(parsed[:data].first[:attributes][:county]).to eq(record.county)
			expect(parsed[:data].first[:attributes][:zip]).to eq(record.zip)
			expect(parsed[:data].first[:attributes][:lat]).to eq(record.lat)
			expect(parsed[:data].first[:attributes][:lon]).to eq(record.lon)
		end

		# name happy path
		it "users can search for markets by name" do 
			record = Market.all.sample
			name = record.name
			city = record.city
			state = record.state
	
			get "/api/v0/markets/search", headers: @headers, params: { name: name }
	
			parsed = JSON.parse(response.body, symbolize_names: true)
			
			expect(response).to have_http_status(200)

			expect(parsed[:data].first[:id].to_i).to eq(record.id)
			expect(parsed[:data].first[:type]).to eq("market")
			expect(parsed[:data].first[:attributes][:name]).to eq(name)
			expect(parsed[:data].first[:attributes][:city]).to eq(city)
			expect(parsed[:data].first[:attributes][:state]).to eq(state)
			expect(parsed[:data].first[:attributes][:vendor_count]).to eq(record.vendor_count)
			expect(parsed[:data].first[:attributes][:street]).to eq(record.street)
			expect(parsed[:data].first[:attributes][:county]).to eq(record.county)
			expect(parsed[:data].first[:attributes][:zip]).to eq(record.zip)
			expect(parsed[:data].first[:attributes][:lat]).to eq(record.lat)
			expect(parsed[:data].first[:attributes][:lon]).to eq(record.lon)
		end

		# state, city happy path
		it "users can search for markets by state and city" do 
			record = Market.all.sample
			name = record.name
			city = record.city
			state = record.state
	
			get "/api/v0/markets/search", headers: @headers, params: { state: state, city: city }
	
			parsed = JSON.parse(response.body, symbolize_names: true)
			
			expect(response).to have_http_status(200)

			expect(parsed[:data].first[:id].to_i).to eq(record.id)
			expect(parsed[:data].first[:type]).to eq("market")
			expect(parsed[:data].first[:attributes][:name]).to eq(name)
			expect(parsed[:data].first[:attributes][:city]).to eq(city)
			expect(parsed[:data].first[:attributes][:state]).to eq(state)
			expect(parsed[:data].first[:attributes][:vendor_count]).to eq(record.vendor_count)
			expect(parsed[:data].first[:attributes][:street]).to eq(record.street)
			expect(parsed[:data].first[:attributes][:county]).to eq(record.county)
			expect(parsed[:data].first[:attributes][:zip]).to eq(record.zip)
			expect(parsed[:data].first[:attributes][:lat]).to eq(record.lat)
			expect(parsed[:data].first[:attributes][:lon]).to eq(record.lon)
		end

		# state, name happy path
		it "users can search for markets by state and name" do 
			record = Market.all.sample
			name = record.name
			city = record.city
			state = record.state
	
			get "/api/v0/markets/search", headers: @headers, params: { state: state, name: name }
	
			parsed = JSON.parse(response.body, symbolize_names: true)
			
			expect(response).to have_http_status(200)

			expect(parsed[:data].first[:id].to_i).to eq(record.id)
			expect(parsed[:data].first[:type]).to eq("market")
			expect(parsed[:data].first[:attributes][:name]).to eq(name)
			expect(parsed[:data].first[:attributes][:city]).to eq(city)
			expect(parsed[:data].first[:attributes][:state]).to eq(state)
			expect(parsed[:data].first[:attributes][:vendor_count]).to eq(record.vendor_count)
			expect(parsed[:data].first[:attributes][:street]).to eq(record.street)
			expect(parsed[:data].first[:attributes][:county]).to eq(record.county)
			expect(parsed[:data].first[:attributes][:zip]).to eq(record.zip)
			expect(parsed[:data].first[:attributes][:lat]).to eq(record.lat)
			expect(parsed[:data].first[:attributes][:lon]).to eq(record.lon)
		end
		
		# city, state, name happy path
		it "users can search for markets by city, state, and name" do 
			record = Market.all.sample
			name = record.name
			city = record.city
			state = record.state

			get "/api/v0/markets/search", headers: @headers, params: { state: state, city: city, name: name }
			parsed = JSON.parse(response.body, symbolize_names: true)
			
			expect(response).to have_http_status(200)

			expect(parsed[:data].first[:id].to_i).to eq(record.id)
			expect(parsed[:data].first[:type]).to eq("market")
			expect(parsed[:data].first[:attributes][:name]).to eq(name)
			expect(parsed[:data].first[:attributes][:city]).to eq(city)
			expect(parsed[:data].first[:attributes][:state]).to eq(state)
			expect(parsed[:data].first[:attributes][:vendor_count]).to eq(record.vendor_count)
			expect(parsed[:data].first[:attributes][:street]).to eq(record.street)
			expect(parsed[:data].first[:attributes][:county]).to eq(record.county)
			expect(parsed[:data].first[:attributes][:zip]).to eq(record.zip)
			expect(parsed[:data].first[:attributes][:lat]).to eq(record.lat)
			expect(parsed[:data].first[:attributes][:lon]).to eq(record.lon)
		end

		# sad path - city (only) attribute 
		it "will gracefully handle error thrown when city is the only attribute passed in params" do 
			record = Market.all.sample
			city = record.city

			get "/api/v0/markets/search", headers: @headers, params: { city: city }

			parsed = JSON.parse(response.body, symbolize_names: true)
			
			expect(response).not_to be_successful
			expect(response).to have_http_status(422)
			expect(parsed).to have_key(:error)
			expect(parsed[:error]).to be_a(Hash)
			expect(parsed[:error][:message]).to eq("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.")
		end

		# sad path - city, name attributes
		it "will gracefully handle error thrown when city and name are the only two attributes passed in params" do 
			record = Market.all.sample
			city = record.city
			name = record.name

			get "/api/v0/markets/search", headers: @headers, params: { city: city, name: name }

			parsed = JSON.parse(response.body, symbolize_names: true)
			
			expect(response).not_to be_successful
			expect(response).to have_http_status(422)
			expect(parsed).to have_key(:error)
			expect(parsed[:error]).to be_a(Hash)
			expect(parsed[:error][:message]).to eq("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.")
		end
	end

	describe "ATMs near market search endpoint" do
		it "given a market, this endpoint will return a list of cash dispensers nearby, ordered by ascending distance" do
			pm_id = 330318
			market = create(:market, id: pm_id)

			# get "/api/v0/markets/#{market.id}/nearest_atms", headers: { "Content-Type": "application/json" }
			get "/api/v0/markets/#{pm_id}/nearest_atms", headers: { "Content-Type": "application/json" }

			res_hash = JSON.parse(response.body, symbolize_names: true)

			expect(response).to have_http_status(:success)
		end
	end
end