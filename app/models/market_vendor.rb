class MarketVendor < ApplicationRecord 
	belongs_to :market
	belongs_to :vendor

	validates :market_id, presence: true
	validates :market_id, numericality: { only_integer: true }
	validates :vendor_id, presence: true
	validates :vendor_id, numericality: { only_integer: true }
end