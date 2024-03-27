require 'rails_helper'

RSpec.describe Vendor, type: :model do
  describe 'relationships' do 
    it { should have_many(:market_vendors) }
    it { should have_many(:markets).through(:market_vendors) }
  end
  
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:contact_name) }
    it { should validate_presence_of(:contact_phone) }
  end

  it 'is valid only when true or false' do
    vendor_params_1 = {
    name: "Buzzy Bees",
    description: "local honey and wax products",
    contact_name: "Berly Couwer",
    contact_phone: "8389928383",
    credit_accepted: false
    }

    vendor_params_2 = {
    name: "Buzzy Bees",
    description: "local honey and wax products",
    contact_name: "Berly Couwer",
    contact_phone: "8389928383",
    credit_accepted: true
    }

    vendor_params_3 = {
    name: "Buzzy Bees",
    description: "local honey and wax products",
    contact_name: "Berly Couwer",
    contact_phone: "8389928383",
    credit_accepted: nil
    }

    vendor_1 = Vendor.new(vendor_params_1)
    vendor_2 = Vendor.new(vendor_params_2)
    vendor_3 = Vendor.new(vendor_params_3)


    expect(vendor_1.save).to eq(true)
    expect(vendor_2.save).to eq(true)
    expect(vendor_3.save).to eq(false)
  end
end