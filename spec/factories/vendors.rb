FactoryBot.define do
  factory :vendor do
    name { Faker::Company.name }
    description { Faker::Company.catch_phrase }
    contact_name { Faker::Music::Hiphop.artist }
    contact_phone { "1-800-Contact-Number" }
    credit_accepted { Faker::Boolean.boolean }
  end
end
