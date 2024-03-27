require 'rails_helper'

RSpec.describe VendorSerializer do
  it 'exists' do
    serializer = VendorSerializer.new

    expect(serializer).to be_a(VendorSerializer)
  end

  describe '#self.format_vendor' do
    it 'can return data with the correct formatting' do
      vendor = create(:vendor, credit_accepted: false)

      formatted_response = VendorSerializer.format_vendor(vendor)

      expect(formatted_response).to have_key(:data)
      expect(formatted_response[:data]).to be_a(Hash)

      data = formatted_response[:data]

      expect(data).to have_key(:id)
      expect(data[:id]).to be_a(String)

      expect(data).to have_key(:type)
      expect(data[:type]).to eq("vendor")

      expect(data).to have_key(:attributes)
      expect(data[:attributes]).to be_a(Hash)

      attributes = data[:attributes]

      expect(attributes).to have_key(:name)
      expect(attributes[:name]).to be_a(String)

      expect(attributes).to have_key(:description)
      expect(attributes[:description]).to be_a(String)

      expect(attributes).to have_key(:contact_name)
      expect(attributes[:contact_name]).to be_a(String)

      expect(attributes).to have_key(:contact_phone)
      expect(attributes[:contact_phone]).to be_a(String)

      expect(attributes).to have_key(:credit_accepted)
      expect(attributes[:credit_accepted]).to eq(false)
    end
  end

  describe '#self.serialize_market_vendors(market_vendors)' do
    it 'will format the data correctly for market_vendors' do
      vendors = create_list(:vendor, 3, credit_accepted: false)

      formatted_vendors = VendorSerializer.serialize_market_vendors(vendors)

      expect(formatted_vendors).to have_key(:data)
      expect(formatted_vendors[:data]).to be_a(Array)

      vendor_data = formatted_vendors[:data].first

      expect(vendor_data).to have_key(:attributes)
      expect(vendor_data[:attributes]).to be_a(Hash)

      attributes = vendor_data[:attributes]

      expect(attributes).to have_key(:name)
      expect(attributes[:name]).to be_a(String)

      expect(attributes).to have_key(:description)
      expect(attributes[:description]).to be_a(String)

      expect(attributes).to have_key(:contact_name)
      expect(attributes[:contact_name]).to be_a(String)

      expect(attributes).to have_key(:contact_phone)
      expect(attributes[:contact_phone]).to be_a(String)

      expect(attributes).to have_key(:credit_accepted)
      expect(attributes[:credit_accepted]).to eq(false)
    end
  end
end