class Atm
	attr_reader :id, :type, :distance, :name, :address, :lat, :lon

	def initialize(attributes)
		@id = nil
		@type = "atm"
		@name = attributes[:poi][:name]
		@address = attributes[:address][:freeformAddress]
		@lat = attributes[:position][:lat]
		@lon = attributes[:position][:lon]
		@distance = attributes[:dist]
	end
end