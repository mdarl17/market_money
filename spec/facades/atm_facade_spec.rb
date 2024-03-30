require "rails_helper"

RSpec.describe "Atm Facade", :vcr, type: :type do 
	before(:each) do 
		load_test_data
		market = Market.all.sample
		@facade = AtmFacade.new(lat: market.lat, lon: market.lon)
	end

	describe "methods" do 
		describe "#nearby_atms" do 
			it "returns a list of the 10 nearest atms from a given latitutde and longitude coordinate" do 
				ordered_list = @facade.nearby_atms
			end
		end
	end
end 