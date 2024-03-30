def load_test_data
	create_list(:market, 3)
	create_list(:vendor, 5)
	
	MarketVendor.create!(market_id: Market.first.id, vendor_id: Vendor.first.id)
	MarketVendor.create!(market_id: Market.first.id, vendor_id: Vendor.fourth.id)
	MarketVendor.create!(market_id: Market.first.id, vendor_id: Vendor.third.id)
	MarketVendor.create!(market_id: Market.second.id, vendor_id: Vendor.second.id)
	MarketVendor.create!(market_id: Market.third.id, vendor_id: Vendor.fifth.id)
end