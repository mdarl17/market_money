class Api::V0::MarketsController < ApplicationController 
	# /api/v0/markets
	def index
		markets = Market.all
		render json: MarketSerializer.new(markets)
	end
end