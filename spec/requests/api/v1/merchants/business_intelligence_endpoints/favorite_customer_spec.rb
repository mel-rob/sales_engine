require 'rails_helper'

describe "Merchant's favorite customer" do
  it 'returns a single customer who has conducted the most total number of successful transactions for that merchant' do
    merchant_1 = create(:merchant)
    item_1 = merchant_1.items.create(name: 'Item 1', description: 'I am an item', unit_price: 100)

    customer_1 = create(:customer)
    invoice_1 = Invoice.create(merchant_id: merchant_1.id, customer_id: customer_1.id)
    invoice_2 = Invoice.create(merchant_id: merchant_1.id, customer_id: customer_1.id)
    invoice_1.invoice_items.create(item_id: item_1.id, quantity: 20, unit_price: 100, created_at: "2015-06-14 11:55:00 UTC")
    invoice_2.invoice_items.create(item_id: item_1.id, quantity: 20, unit_price: 100, created_at: "2015-06-14 11:55:00 UTC")
    transaction_1 = invoice_1.transactions.create(result: 'success')
    transaction_2 = invoice_2.transactions.create(result: 'success')

    customer_2 = create(:customer)
    invoice_4 = Invoice.create(merchant_id: merchant_1.id, customer_id: customer_2.id)
    invoice_5 = Invoice.create(merchant_id: merchant_1.id, customer_id: customer_2.id)
    invoice_4.invoice_items.create(item_id: item_1.id, quantity: 20, unit_price: 100, created_at: "2015-06-14 11:55:00 UTC")
    invoice_5.invoice_items.create(item_id: item_1.id, quantity: 20, unit_price: 100, created_at: "2015-06-14 11:55:00 UTC")
    transaction_4 = invoice_4.transactions.create(result: 'failed')
    transaction_5 = invoice_5.transactions.create(result: 'success')

    invoice_6 = Invoice.create(merchant_id: merchant_1.id, customer_id: customer_1.id)
    invoice_6.invoice_items.create(item_id: item_1.id, quantity: 20, unit_price: 100, created_at: "2015-06-14 11:55:00 UTC")
    transaction_6 = invoice_6.transactions.create(result: 'success')

    get "/api/v1/merchants/#{merchant_1.id}/favorite_customer"

    expect(response).to be_successful

    customer = JSON.parse(response.body)['data']

    expect(customer['attributes']['id']).to eq(customer_1.id)
  end
end
