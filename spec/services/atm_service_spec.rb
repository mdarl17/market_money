require "rails_helper"

RSpec.describe "ATM Service", type: :service do 
	before(:each) do 
		load_test_data 
		@service = AtmService.new
	end
	describe "#find_nearby_atms(lat, lon)" do 
		it "given latitude and longitude coordinates of a Market, it returns a list of nearby ATM's" do
			market = Market.all.sample
			lat = market.lat
			lon = market.lon

			atm_list_hash = @service.find_nearby_atms(lat, lon)
			results_array = atm_list_hash[:results]
			Atm
			require 'pry'; binding.pry
		end
	end
end 