class AtmFacade

  def initialize(market_id)
    @market_id = market_id
  end

  def nearest_atms
    service = AtmService.new
    service.atm_info(@market_id)
  end
end

  #   market = Market.find(params[:id])
    
  #   lat = market.lat
  #   lon = market.lon

  #   conn = Faraday.new(url: "https://api.tomtom.com/search/2/categorySearch/automatic_teller_machine.json") do |f|
  #     f.params["key"] = "SFrEbfhJA2ssKQ2IIiGUqQK5zIydAa8v"
  #   end

  #   response = conn.get("?lat=#{lat}&lon=#{lon}")

  #   json = JSON.parse(response.body, symbolize_names: true)

  #   results = json[:results]

  #   bank_info = []
  #   if results
  #     bank_info = results.map do |bank|
  #       {
  #         id: nil,
  #         type: "atm",
  #         attributes: {
  #           name: bank[:poi][:name],
  #           address: bank[:address][:freeformAddress],
  #           lat: bank[:position][:lat],
  #           lon: bank[:position][:lon],
  #           distance: bank[:dist]
  #         }

  #       }
  #     end
  #   end
    
  #   render json: {data: bank_info}
  # end