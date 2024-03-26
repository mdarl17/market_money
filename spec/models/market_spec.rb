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

	describe "validations" do 
		it { should validate_presence_of(:name).with_message("Name can't be blank.") }
		it { should validate_presence_of(:street).with_message("Street can't be blank.") }
		it { should validate_presence_of(:city).with_message("City can't be blank.") }
		it { should validate_presence_of(:county).with_message("County can't be blank.") }
		it { should validate_presence_of(:state).with_message("State can't be blank.") }
		it { should validate_presence_of(:zip).with_message("Zip can't be blank.") }
		it { should validate_presence_of(:lat).with_message("Lat can't be blank.") }
		it { should validate_presence_of(:lon).with_message("Lon can't be blank.") }
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

	it "throws an error if any attributes are missing" do 
		no_name = Market.new(
			name: "",
			street: "2676 Brookpark Rd.",
			city: "West Park",
			state: "OH",
			county: "Cuyahogo",
			zip: "44142",
			lat: "-53.3",
			lon: "72.8"
		)

		expect(no_name.save).to eq(false)
		expect(no_name).not_to be_valid
		expect(no_name.errors.messages[:name].first).to include("Name can't be blank")
	end
end