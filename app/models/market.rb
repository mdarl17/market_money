class Market < ApplicationRecord 
	validates :name, :street, :city, :county, :state, :zip, :lat, :lon, presence: { message: "%{attribute} can't be blank." }

	has_many :market_vendors
	has_many :vendors, through: :market_vendors
	
	def vendor_count
		vendors.count
	end

	def self.titleize(state)
		if state
			return state.split(" ").map(&:capitalize).join(" ")
		end
	end

	def self.filter_params(*args)
		return args.first.filter do |param, val|
			val != nil
		end
	end

	def self.search(*args)

		params = filter_params(args.first)
		if params.count == 1 && !params[:name]
			state = titleize(params[:state])
			return self.where(state: state)

		elsif params.count == 1
			return self.where(name: params[:name])
		end

		if params.count == 2 && !params[:name]
			state = titleize(params[:state])
			return self.where(city: params[:city]).where(state: state)
		elsif params.count == 2
			state = titleize(params[:state])
			return self.where(state: state).where(name: params[:name])
		end

		if params.count == 3
			state = titleize(params[:state])
			return self.where(city: params[:city]).where(state: state).where(name: params[:name])
		end
	end
end

