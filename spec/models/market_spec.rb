require "rails_helper" 

RSpec.describe Market, :vcr, type: :model do 
	before(:each) do 
		create_list(:market, 3)
		create_list(:vendor, 5)

		MarketVendor.create!(market_id: Market.first.id, vendor_id: Vendor.fifth.id)
		MarketVendor.create!(market_id: Market.first.id, vendor_id: Vendor.third.id)
		MarketVendor.create!(market_id: Market.second.id, vendor_id: Vendor.fourth.id)
		MarketVendor.create!(market_id: Market.third.id, vendor_id: Vendor.third.id)
		MarketVendor.create!(market_id: Market.third.id, vendor_id: Vendor.fifth.id)
	end

	describe "relationships" do 
		it { should have_many(:market_vendors) }
		it { should have_many(:vendors).through(:market_vendors)  }
	end

	describe "instance methods" do
		describe "#vendor_count" do 
			it "returns the number of vendors at a particular market" do 
				market1 = Market.first
				market2 = Market.second
				market3 = Market.third

				expect(market1.vendor_count).to eq(2)
				expect(market2.vendor_count).to eq(1)
				expect(market3.vendor_count).to eq(2)
			end
		end
	end
end 