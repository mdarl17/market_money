require "rails_helper"

RSpec.describe "ATM Service", :vcr, type: :service do 
	before(:each) do 
		load_test_data 
		@service = AtmService.new
	end

	describe "#find_nearby_atms(lat, lon)" do 
		it "given latitude and longitude coordinates of a Market, it returns a list of nearby ATM's" do
			market = Market.all.sample
			atm_list_hash = @service.find_nearby_atms(market.lat, market.lon)
			results_array = atm_list_hash[:results]
			
			expect(results_array.first.keys).to include(:type, :position, :dist, :poi, :address)

			expect(results_array.first[:type]).to be_a(String)

			expect(results_array.first[:position]).to be_a(Hash)
			expect(results_array.first[:position].keys).to match_array([:lat, :lon])
			expect(results_array.first[:position][:lat]).to be_a(Float)
			expect(results_array.first[:position][:lon]).to be_a(Float)
			
			expect(results_array.first[:dist]).to be_a(Float)
			
			expect(results_array.first[:poi]).to be_a(Hash)
			expect(results_array.first[:poi].keys).to be_include(:name)

			expect(results_array.first[:address]).to be_a(Hash)
			expect(results_array.first[:address].keys).to include(:freeformAddress)
			expect(results_array.first[:address][:freeformAddress]).to be_a(String)
		end
	end
end 