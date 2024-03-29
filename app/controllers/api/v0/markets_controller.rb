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
		if permitted_params?
			markets = Market.search_by_params(params[:state], params[:city], params[:name])
			render json: MarketSerializer.new(markets), status: :ok
		else
			render json: ErrorSerializer.new(unpermitted_params_message).serialize_json, status: 422
		end
	end

	private
	def permitted_params?
		if params[:city] && params[:name] == nil && params[:state] == nil
			return false
		elsif params[:name] && params[:city] && params[:state] == nil
			return false
		end
		true
	end

	def unpermitted_params_message
		ErrorMessage.new("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.", 422)
	end

end