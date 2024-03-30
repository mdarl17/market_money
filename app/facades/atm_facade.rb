class AtmFacade
	def initialize(market)
		@lat = market[:lat]
		@lon = market[:lon]
	end
	
	def nearby_atms
		service = AtmService.new
		atms = service.find_nearby_atms(@lat, @lon)
		ordered = order_by_distance(atms[:results])
		create_atm_poros(ordered)
	end

	def order_by_distance(results_array)
		results_array.sort_by{ |atm| atm[:dist] }
	end

	def create_atm_poros(atm_array)
		atm_array.map do |atm|
			Atm.new(atm)
		end
	end
end