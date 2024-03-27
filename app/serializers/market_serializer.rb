class MarketSerializer 
  include JSONAPI::Serializer

  attributes :vendor_count, :name, :street, :city, :county, :state, :zip, :lat, :lon
end
