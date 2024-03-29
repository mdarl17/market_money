class Market < ApplicationRecord
	validates :name, :street, :city, :county, :state, :zip, :lat, :lon, presence: { message: "%{attribute} can't be blank." }

	has_many :market_vendors
	has_many :vendors, through: :market_vendors
	
	def vendor_count
		vendors.count
	end

	def self.search_by_params(state, city, name)
		# state = params[:state]
		# city = params[:city]
		# name = params[:name]

		markets = Market.all

		markets = markets.where("state ILIKE ?", "#{state}") if state
		markets = markets.where("city ILIKE ?", "#{city}") if city
		markets = markets.where("name ILIKE ?", "#{name}") if name

		markets
	end
end

