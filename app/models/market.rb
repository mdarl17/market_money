class Market < ApplicationRecord
	validates :name, :street, :city, :county, :state, :zip, :lat, :lon, presence: { message: "%{attribute} can't be blank." }

	has_many :market_vendors
	has_many :vendors, through: :market_vendors
	
	def vendor_count
		vendors.count
	end

	def self.search_by_params(params)
		if params[:state] && params[:name] && params[:city]
			Market.select("*").where("state LIKE '%#{params[:state]}%' AND name LIKE '%#{params[:name]}%' AND city LIKE '%#{params[:city]}%'")
		elsif params[:city] != nil && params[:name] != nil
			ErrorMessage.new("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.", 422)
		elsif params[:state] && params[:name]
			Market.select("*").where("state LIKE '%#{params[:state]}%' AND name LIKE '%#{params[:name]}%'")
		elsif params[:state] && params[:city]
			Market.select("*").where("state LIKE '%#{params[:state]}%' AND city LIKE '%#{params[:city]}%'")
		elsif params[:state]
			Market.select("*").where("state LIKE '%#{params[:state]}%'")
		elsif params[:name]
			Market.select("*").where("name LIKE '%#{params[:name]}%'")
		else
			ErrorMessage.new("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.", 422)
		end
	end
end

