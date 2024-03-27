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
end