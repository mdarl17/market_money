class Api::V0::MarketsController < ApplicationController 

	# /api/v0/markets
	def index
		markets = Market.all
		render json: MarketSerializer.new(markets)
	end

	# /api/v0/markets/:id
	def show 
		market = Market.find(params[:id])
		render json: MarketSerializer.new(market)
	end

	# /api/v0/markets/search
	def search
		begin
			if !params[:state] && params[:city]
				raise StandardError, "Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint."
			end

			results = Market.search_db(city: params[:city], state: params[:state], name: params[:name])
			render json: MarketSerializer.new(results)
		
		rescue StandardError => e
			render json: ErrorSerializer.new(ErrorMessage.new(e.message, 422)), status: :unprocessable_entity
		end
	end	

	def nearest_atms 
		market = Market.find(params[:id])
		lat = market.lat
		lon = market.lon
		facade = AtmFacade.new(lat: lat, lon: lon)
		results = facade.nearby_atms
		render json: AtmSerializer.new(results)
	end 

	private 
	
end