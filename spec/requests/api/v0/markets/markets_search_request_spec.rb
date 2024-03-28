require 'rails_helper'

RSpec.describe "Market Money API Search Markets" do
  before(:each) do
    @markets = create_list(:market, 3, state: "Colorado")
    @extra_market = create(:market, state: "Arizona", city: "Albuquerque")
    @state = @markets.first.state
    @city = @markets.first.city
    @name = @markets.first.name
  end

  it 'can search for markets by state' do
    headers = {"CONTENT_TYPE" => "application/json"}

    get "/api/v0/markets/search?state=#{@state}", headers: headers

    expect(response).to be_successful
    expect(response.status).to eq(200)

    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data[:data].count).to eq(3)
    expect(response_data[:data].first[:attributes][:name]).to eq(@name)
    expect(response_data[:data].first[:attributes][:state]).to eq(@state)
    expect(response_data[:data].first[:attributes][:city]).to eq(@city)
  end

  it 'can search for markets by state and city at the same time' do
    headers = {"CONTENT_TYPE" => "application/json"}

    get "/api/v0/markets/search?state=#{@state}&city=#{@city}", headers: headers

    expect(response).to be_successful
    expect(response.status).to eq(200)

    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data[:data].first[:attributes][:name]).to be_a(String)
    expect(response_data[:data].first[:attributes][:state]).to be_a(String)
    expect(response_data[:data].first[:attributes][:city]).to be_a(String)
  end

  it 'can search for markets by state, city, and name at the same time' do
    headers = {"CONTENT_TYPE" => "application/json"}

    get "/api/v0/markets/search?state=#{@state}&city=#{@city}&name=#{@name}", headers: headers

    expect(response).to be_successful
    expect(response.status).to eq(200)

    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data[:data].first[:attributes][:name]).to be_a(String)
    expect(response_data[:data].first[:attributes][:state]).to be_a(String)
    expect(response_data[:data].first[:attributes][:city]).to be_a(String)
  end

  it 'can search for markets by state and name at the same time' do
    headers = {"CONTENT_TYPE" => "application/json"}

    get "/api/v0/markets/search?state=#{@state}&name=#{@name}", headers: headers

    expect(response).to be_successful
    expect(response.status).to eq(200)

    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data[:data].first[:attributes][:name]).to be_a(String)
    expect(response_data[:data].first[:attributes][:state]).to be_a(String)
    expect(response_data[:data].first[:attributes][:city]).to be_a(String)
  end

  it 'can search for markets by name' do
    headers = {"CONTENT_TYPE" => "application/json"}

    get "/api/v0/markets/search?name=#{@name}", headers: headers

    expect(response).to be_successful
    expect(response.status).to eq(200)

    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data[:data].first[:attributes][:name]).to be_a(String)
    expect(response_data[:data].first[:attributes][:state]).to be_a(String)
    expect(response_data[:data].first[:attributes][:city]).to be_a(String)
  end

  it 'returns no markets if a valid search parameter is included but no markets match' do
    headers = {"CONTENT_TYPE" => "application/json"}

    get "/api/v0/markets/search?state=CANADA", headers: headers

    expect(response).to be_successful
    expect(response.status).to eq(200)

    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data[:data]).to be_a(Array)
    expect(response_data[:data].empty?).to eq(true)
  end

  it 'responds with an error when provided an invalid set of parameters' do
    headers = {"CONTENT_TYPE" => "application/json"}

    get "/api/v0/markets/search?market=thatone", headers: headers

    expect(response).not_to be_successful
    expect(response.status).to eq(422)

    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data[:errors]).to be_a(Array)
    expect(response_data[:errors].first[:detail]).to eq("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.")
  end
end