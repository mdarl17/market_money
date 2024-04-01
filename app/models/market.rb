class Market < ApplicationRecord 

	has_many :market_vendors
	has_many :vendors, through: :market_vendors
	
	validates :name, :street, :city, :county, :state, :zip, :lat, :lon, presence: { message: "%{attribute} can't be blank." }

	def vendor_count
		vendors.count
	end

	def self.fuzzy_find(column, val)
		where("#{column} ILIKE ?", val)
	end

	def self.filter_params(*args)
		return args.first.filter do |param, val|
			val != nil
		end
	end

	def self.search_db(*args)
		params = filter_params(args.first)
		city = params[:city]
		state = params[:state]
		name = params[:name]

		if city && state && name
			return fuzzy_find("city", city).fuzzy_find("state", state).fuzzy_find("name", name)
		end

		if city && state
			return fuzzy_find("city", city).fuzzy_find("state", state)
		end

		if name && state
			return fuzzy_find("name", name).fuzzy_find("state", state)
		end

		if name
			return fuzzy_find("name", name)
		end

		if state
			return fuzzy_find("state", state)
		end
	end
end

