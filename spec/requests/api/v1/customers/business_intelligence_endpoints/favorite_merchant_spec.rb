require 'rails_helper'

describe "customer's favorite merchant" do
  it 'returns a single merchant with the most transactions for a customer' do
    customer_1 = create(:customer)

    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    invoice = Invoice.create(status: 'shipped', merchant_id: merchant_1.id, customer_id: customer_1.id)
    item = create(:item, merchant_id: merchant_1.id)
    invoice.invoice_items.create(item_id: item.id)
    invoice.transactions.create(result: 'success')

    invoice_2 = Invoice.create(status: 'shipped', merchant_id: merchant_2.id, customer_id: customer_1.id)
    item_2 = create(:item, merchant_id: merchant_2.id)
    invoice_2.invoice_items.create(item_id: item_2.id)
    invoice_2.transactions.create(result: 'failed')

    invoice_3 = Invoice.create(status: 'shipped', merchant_id: merchant_1.id, customer_id: customer_1.id)
    item_3 = create(:item, merchant_id: merchant_1.id)
    invoice_3.invoice_items.create(item_id: item_3.id)
    invoice_3.transactions.create(result: 'success')

    get "/api/v1/customers/#{customer_1.id}/favorite_merchant"

    customer = JSON.parse(response.body)['data']

    expect(customer['attributes']['id']).to eq(merchant_1.id)
  end
end
