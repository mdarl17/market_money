class MarketSerializer 
  include JSONAPI::Serializer

  attributes :name, :street, :city, :county, :state, :zip, :lat, :lon
  attribute :vendor_count

  def vendor_count
    @market.get_vendor_count
  end
end
