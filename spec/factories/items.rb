FactoryBot.define do
  factory :item do
    name { "I'm an Item!" }
    description { "I have a description." }
    unit_price { "12345"}
    created_at { "2012-03-27 14:53:59 UTC" }
    updated_at { "2012-03-27 14:53:59 UTC" }
    merchant
  end
end
