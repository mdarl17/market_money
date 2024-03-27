class VendorSerializer
  
  def self.format_vendor(vendor)
    {
      data: {
        id: vendor.id.to_s,
        type: "vendor",
        attributes: {
          name: vendor.name,
          description: vendor.description,
          contact_name: vendor.contact_name,
          contact_phone: vendor.contact_phone,
          credit_accepted: vendor.credit_accepted
        }
      }
    }
  end

  def self.serialize_market_vendors(vendors)
    {data: format_multiple_vendors(vendors)}
  end

  def self.format_multiple_vendors(vendors)
    vendors.map do |vendor|
      {
        id: vendor.id.to_s,
        type: "vendor",
        attributes: {
          name: vendor.name,
          description: vendor.description,
          contact_name: vendor.contact_name,
          contact_phone: vendor.contact_phone,
          credit_accepted: vendor.credit_accepted
        }
      }
    end
  end
end