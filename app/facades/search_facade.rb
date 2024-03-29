# class MarketFacade
	# def initialize(city=nil, state=nil, name=nil)
	# 	@city = city
	# 	@state = state
	# 	@name = name
	# end

# 	def search(city=nil, state=nil, name=nil)
# 		if !city && !name
# 			Market.state(state)
# 		elsif state && city && !name
# 			Market.city_and_state(city, state)
# 		elsif state && city && name 
# 			Market.city_and_state_and_name(city, state, name)
# 		elsif state && name && !city
# 			Market.state_and_name
# 		end
# 	end

# 	def titleize 
# 		self.split(" ").map(&:capitalize).join(" ")
# 	end
# end