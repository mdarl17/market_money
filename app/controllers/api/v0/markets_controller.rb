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

	def search
		markets = Market.search_by_params(search_params)
		if markets.class == ErrorMessage
			unpermitted_param(markets)
		else
			render json: MarketSerializer.new(markets)
		end
	end

	private
	def search_params
		params.permit(:state, :city, :name, :market)
	end

	def unpermitted_param(exception)
		render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 422)).serialize_json, status: 422
	end

end