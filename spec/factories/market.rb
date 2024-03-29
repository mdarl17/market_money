FactoryBot.define do
  factory :market do
    name { Faker::Company.name + " Market" }
    street { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    county { Faker::Address.community }
    zip { Faker::Address.zip_code }
    lat { Faker::Address.latitude }
    lon { Faker::Address.longitude }
  end
end