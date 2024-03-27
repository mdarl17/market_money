class Vendor < ApplicationRecord
  has_many :market_vendors
  has_many :markets, through: :market_vendors

  validates :name, presence: true
  validates :description, presence: true
  validates :contact_name, presence: true
  validates :contact_phone, presence: true

  validate :credit_accepted_is_boolean, on: :create
  
  def credit_accepted_is_boolean
    unless credit_accepted == true || credit_accepted == false
      errors.add(:credit_accepted, "must be true or false")
    end
  end

end