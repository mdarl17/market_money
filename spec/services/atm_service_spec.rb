require 'rails_helper'

RSpec.describe AtmService do
  it 'exists' do
    service = AtmService.new

    expect(service).to be_a(AtmService)
  end

  before(:each) do
    json_response = File.read("spec/fixtures/nearest_atms_fixture.json")

    stub_request(:get, "https://api.tomtom.com/search/2/categorySearch/automatic_teller_machine.json?lat=37.583311&lon=-79.048573").
      with(
      query: {
        'key'=> "SFrEbfhJA2ssKQ2IIiGUqQK5zIydAa8v"
      }).
    to_return(status: 200, body: json_response, headers: {})
  end

  it 'can return properly structured data' do
    data_structure = [{
      id: nil,
      type: "atm",
      attributes: {
        name: "name",
        address: "address",
        lat: "lat",
        lon: "lon",
        distance: "dist"
      }
    }]

    atm = {results: [{poi: {name: "name"}, address: {freeformAddress: "address"}, position: {lat: "lat", lon: "lon"}, dist: "dist"}]}
    
    service = AtmService.new

    expect(service.get_results(atm)).to eq({data: data_structure})
  end
end