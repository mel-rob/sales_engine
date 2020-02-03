require 'rails_helper'

RSpec.describe 'Merchants total revenue' do
  it 'returns total revenue for given day' do
    customer = create(:customer)

    merchant_1 = create(:merchant, name: 'Merchant 1')
    invoice_1 = Invoice.create(status: 'shipped', merchant_id: merchant_1.id, customer_id: customer.id, created_at: "2015-06-14 11:55:00 UTC")
    item_1 = merchant_1.items.create(name: 'Item 1', description: "I'm an item!", unit_price: 100)
    invoice_1.invoice_items.create(item_id: item_1.id, quantity: 20, unit_price: 100, created_at: "2015-06-14 11:55:00 UTC")
    invoice_1.transactions.create(result: 'success', created_at: "2015-06-14 11:55:00 UTC")

    merchant_2 = create(:merchant, name: 'Merchant 2')
    invoice_2 = Invoice.create(status: 'shipped', merchant_id: merchant_2.id, customer_id: customer.id, created_at: "2015-06-14 11:55:00 UTC")
    item_2 = merchant_2.items.create(name: 'Item 2', description: "I'm another item!", unit_price: 100)
    invoice_2.invoice_items.create(item_id: item_2.id, quantity: 10, unit_price: 100, created_at: "2015-06-14 11:55:00 UTC")
    invoice_2.transactions.create(result: 'failed', created_at: "2015-06-14 11:55:00 UTC")

    merchant_3 = create(:merchant, name: 'Merchant 3')
    invoice_3 = Invoice.create(status: 'shipped', merchant_id: merchant_3.id, customer_id: customer.id, created_at: "2015-06-14 11:55:00 UTC")
    item_3 = merchant_3.items.create(name: 'Item 3', description: "I'm a different item!", unit_price: 100)
    invoice_3.invoice_items.create(item_id: item_3.id, quantity: 40, unit_price: 100, created_at: "2015-06-14 11:55:00 UTC")
    invoice_3.transactions.create(result: 'success', created_at: "2015-06-14 11:55:00 UTC")

    get '/api/v1/merchants/revenue?date=2015-06-14'

    expect(response).to be_successful

    revenue = JSON.parse(response.body)['data']
    expect(revenue['attributes']['total_revenue']).to eq('60.0')
  end
end
