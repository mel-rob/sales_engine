FactoryBot.define do
  factory :invoice_item do
    quantity { 10}
    unit_price { "200"}
    created_at { "2012-03-27 14:53:59 UTC" }
    updated_at { "2012-03-27 14:53:59 UTC" }
    item
    invoice
  end
end
