require "rails_helper" 

RSpec.describe "search", type: :request do
	before(:each) do 
		load_test_data
		@headers = { Content_Type: "application/json" }
	end

	# state happy path
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
end 