require 'rails_helper' 

RSpec.describe "Market Money API Delete" do
  it "can destroy a vendor" do
    vendor = create(:vendor)
    
    expect{ delete "/api/v0/vendors/#{vendor.id}" }.to change(Vendor, :count).by(-1)
  
    expect{Vendor.find(vendor.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
