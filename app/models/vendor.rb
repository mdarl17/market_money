class Vendor < ApplicationRecord
  has_many :market_vendors
  has_many :markets, through: :market_vendors

  validates :name, presence: true
  validates :description, presence: true
  validates :contact_name, presence: true
  validates :contact_phone, presence: true

  validate :credit_accepted_is_boolean, on: :create
  # validate :attributes_present_count

  def credit_accepted_is_boolean
    unless credit_accepted == true || credit_accepted == false
      errors.add(:credit_accepted, "must be true or false")
    end
  end

  def attributes_present_count
    attributes = [:name, :description, :contact_name, :contact_phone, :credit_accepted]

    attr_count = attributes.count do |attribute|
      self[attribute].present?
    end
    
    unless attr_count == 5
      errors.add(:credit_accepted, "credit_accepted attribute must be present with a boolean value")
    end
  end

end