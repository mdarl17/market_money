class Vendor < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :contact_name, presence: true
  validates :contact_phone, presence: true
  validates :credit_accepted, presence: true, inclusion: [true, false]

end