require 'rails_helper'

RSpec.describe "Item most revenue" do
  it 'returns X items with the most revenue' do
    customer = create(:customer)

    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)

    invoice_1 = Invoice.create(status: 'shipped', merchant_id: merchant_1.id, customer_id: customer.id)
    item_1 = create(:item, merchant_id: merchant_1.id)
    invoice_1.invoice_items.create(item_id: item_1.id, quantity: 20, unit_price: 100)
    invoice_1.transactions.create(result: 'success')

    invoice_2 = Invoice.create(status: 'shipped', merchant_id: merchant_2.id, customer_id: customer.id)
    item_2 = create(:item, merchant_id: merchant_2.id)
    invoice_2.invoice_items.create(item_id: item_2.id, quantity: 10, unit_price: 100)
    invoice_2.transactions.create(result: 'success')

    invoice_3 = Invoice.create(status: 'shipped', merchant_id: merchant_3.id, customer_id: customer.id)
    item_3 = create(:item, merchant_id: merchant_3.id)
    invoice_3.invoice_items.create(item_id: item_3.id, quantity: 40, unit_price: 100)
    invoice_3.transactions.create(result: 'success')

    get '/api/v1/items/most_revenue?quantity=3'

    expect(response).to be_successful

    items = JSON.parse(response.body)['data']

    expect(items[0]['attributes']['id']).to eq(item_3.id)
    expect(items[1]['attributes']['id']).to eq(item_1.id)
    expect(items[2]['attributes']['id']).to eq(item_2.id)
  end
end
