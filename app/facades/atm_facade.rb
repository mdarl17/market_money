class AtmFacade

  def initialize(market_id)
    @market_id = market_id
  end

  def nearest_atms
    service = AtmService.new
    service.atm_info(@market_id)
  end
end