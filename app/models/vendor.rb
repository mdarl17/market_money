class Vendor < ApplicationRecord 
	validates :name, :description, :contact_name, :contact_phone, presence: true
	validates :credit_accepted, inclusion: { in: [true, false] }
	
	# See warning in respective RSpec test re: using `inclusion` matcher
	# validates :credit_accepted, presence: true
	
	has_many :market_vendors 
	has_many :markets, through: :market_vendors
end