class AtmService 
	def find_nearby_atms(lat, lon)
		get_url("/search/2/categorySearch/atm.json?lat=#{lat}&lon=#{lon}")
	end

	def get_url(url)
		res = conn.get(url)
		JSON.parse(res.body, symbolize_names: true)
	end

	def conn
		Faraday.new(url: "https://api.tomtom.com") do |f| 
			f.headers["Content-Type": "application/json"]
			f.params["key"] = Rails.application.credentials.tomtom[:key]
		end
	end
end