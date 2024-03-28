require "rails_helper" 

RSpec.describe MarketVendor, type: :model do 
	describe "relationships" do 
		it { should belong_to(:vendor) }
		it { should belong_to(:market) }
	end
	
	describe "validations" do 
		it { should validate_presence_of(:market_id) }
		it { should validate_numericality_of(:market_id).only_integer }
		it { should validate_presence_of(:vendor_id) }
		it { should validate_numericality_of(:vendor_id).only_integer }
	end

	describe "#existence_check" do
		it 'will throw a validation error if a MarketVendor already exists with a pair of vendor/market when being created' do
			vendor = create(:vendor)
			market = create(:market)
			MarketVendor.create!(market_id: market.id, vendor_id: vendor.id)

			market_vendor = MarketVendor.new(market_id: market.id, vendor_id: vendor.id)

			expect(market_vendor.save).to eq(false)
		end
	end
end 