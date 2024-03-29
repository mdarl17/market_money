require 'rails_helper'

RSpec.describe "Market Money API ATM Search" do
  before(:each) do
    json_response = File.read("spec/fixtures/nearest_atms_fixture.json")

    stub_request(:get, "https://api.tomtom.com/search/2/categorySearch/automatic_teller_machine.json?&lat=37.583311&lon=-79.048573").
      with(
      query: {
        'key'=> "SFrEbfhJA2ssKQ2IIiGUqQK5zIydAa8v"
      }).
      to_return(status: 200, body: json_response, headers: {})
  end

  it 'can return ATMs that are near the market and returns them from closest to furthest' do
    market = create(:market, lat: "37.583311", lon: "-79.048573")

    headers = {"CONTENT_TYPE" => "application/json"}

    get "/api/v0/markets/#{market.id}/nearest_atms", headers: headers

    expect(response).to be_successful
    expect(response.status).to eq(200)

    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data).to have_key(:data)
    expect(response_data[:data]).to be_a(Array)

    expect(response_data[:data].first).to have_key(:attributes)
    expect(response_data[:data].first[:attributes]).to be_a(Hash)

    expect(response_data[:data].first[:attributes]).to have_key(:name)
    expect(response_data[:data].first[:attributes][:name]).to be_a(String)

    expect(response_data[:data].first[:attributes]).to have_key(:address)
    expect(response_data[:data].first[:attributes][:address]).to be_a(String)

    expect(response_data[:data].first[:attributes]).to have_key(:lat)
    expect(response_data[:data].first[:attributes][:lat]).to be_a(Float)

    expect(response_data[:data].first[:attributes]).to have_key(:lon)
    expect(response_data[:data].first[:attributes][:lon]).to be_a(Float)

    expect(response_data[:data].first[:attributes]).to have_key(:distance)
    expect(response_data[:data].first[:attributes][:distance]).to be_a(Float)
  end
  
  it 'will return an empty array if no ATMs are near the location' do
    market = create(:market, lat: "-9999999", lon: "-9999999")

    headers = {"CONTENT_TYPE" => "application/json"}

    get "/api/v0/markets/#{market.id}/nearest_atms", headers: headers

    expect(response).to be_successful
    expect(response.status).to eq(200)

    response_data = JSON.parse(response.body, symbolize_names: true)
    
    expect(response_data).to have_key(:data)
    expect(response_data[:data]).to be_a(Array)
    expect(response_data[:data].empty?).to eq(true)
  end
end
