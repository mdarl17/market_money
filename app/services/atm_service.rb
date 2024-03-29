class AtmService

  def atm_info(market_id)
    market = Market.find(market_id)
    json = get_url("?lat=#{market.lat}&lon=#{market.lon}")
    get_results(json)
  end

  def conn
    Faraday.new(url: "https://api.tomtom.com/search/2/categorySearch/automatic_teller_machine.json") do |f|
      f.params["key"] = "SFrEbfhJA2ssKQ2IIiGUqQK5zIydAa8v"
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_results(json)
  atm_data = []
    if json[:results]
      atm_data = json[:results].map do |atm|
        {
        id: nil,
        type: "atm",
        attributes: {
          name: atm[:poi][:name],
          address: atm[:address][:freeformAddress],
          lat: atm[:position][:lat],
          lon: atm[:position][:lon],
          distance: atm[:dist]
          }
        }
      end
    end
    {data: atm_data}
  end
end