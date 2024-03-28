class MarketVendor < ApplicationRecord 
	belongs_to :market
	belongs_to :vendor

	validates :market_id, presence: true
	validates :market_id, numericality: { only_integer: true }
	validates :vendor_id, presence: true
	validates :vendor_id, numericality: { only_integer: true }

	validate :existence_check, on: :create

	def existence_check
		if MarketVendor.all.any?{|mv| mv.market_id == self.market_id && mv.vendor_id == self.vendor_id}
			errors.add(:market_vendor_association, "between market with market_id=#{self.market_id} and vendor_id=#{self.vendor_id} already exists")
		end
	end
end