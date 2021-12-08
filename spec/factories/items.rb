FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    description { Faker::Hacker.say_something_smart }
    unit_price { Faker::Commerce.price }
    merchant_id { nil }
  end
end
