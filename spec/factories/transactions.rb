FactoryBot.define do
  factory :transaction do
    credit_card_number { "123456" }
    credit_card_expiration_date { "01292020" }
    result { "success" }
    created_at { "2012-03-27 14:53:59 UTC" }
    updated_at { "2012-03-27 14:53:59 UTC" }
    invoice
  end
end
