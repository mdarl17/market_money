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
				raise StandardError, "The city attribute can not be present without the state attribute"
			end
				results = Market.search(city: params[:city], state: params[:state], name: params[:name])
				render json: MarketSerializer.new(results)

		rescue StandardError => e
			render json: ErrorSerializer.new(ErrorMessage.new(e.message, 422)), status: :unprocessable_entity
		end
	end	

	private 
	
end