class Market < ApplicationRecord 
	attr_reader :vendor_count

	has_many :market_vendors
	has_many :vendors, through: :market_vendors
	
	def vendor_count
		vendors.count
	end
end

